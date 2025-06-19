#!/usr/bin/env python3
"""
MediaWiki User Search Tool
Fuzzy search for users by username, real name, or email
"""

import argparse
import psycopg2
import sys
from typing import List, Tuple


def search_users(search_term: str, limit: int = 10) -> List[Tuple[str, str, str]]:
    """
    Search for users using fuzzy matching on username, real name, or email.
    Returns list of (username, email, real_name) tuples.
    """
    # Connect via Unix socket
    try:
        conn = psycopg2.connect(
            host="/run/postgresql", dbname="mediawiki", user="postgres"
        )
    except psycopg2.Error as e:
        print(f"Error connecting to database: {e}", file=sys.stderr)
        sys.exit(1)

    cur = conn.cursor()

    # Use PostgreSQL's ILIKE for case-insensitive pattern matching
    query = """
    SELECT DISTINCT
        user_name,
        user_email,
        user_real_name,
        CASE
            WHEN LOWER(user_name) = LOWER(%s) THEN 1
            WHEN LOWER(user_email) = LOWER(%s) THEN 1
            WHEN LOWER(user_real_name) = LOWER(%s) THEN 1
            WHEN LOWER(user_name) LIKE LOWER(%s) THEN 2
            WHEN LOWER(user_email) LIKE LOWER(%s) THEN 2
            WHEN LOWER(user_real_name) LIKE LOWER(%s) THEN 2
            ELSE 3
        END as match_score
    FROM mediawiki."user"
    WHERE 
        user_name ILIKE %s
        OR user_email ILIKE %s
        OR user_real_name ILIKE %s
    ORDER BY match_score, user_name
    LIMIT %s
    """

    # Create search pattern with wildcards
    search_pattern = f"%{search_term}%"

    # Execute query with all parameters
    cur.execute(
        query,
        (
            search_term,
            search_term,
            search_term,  # Exact match checks
            search_pattern,
            search_pattern,
            search_pattern,  # Pattern match checks
            search_pattern,
            search_pattern,
            search_pattern,  # WHERE clause
            limit,
        ),
    )

    results = []
    for row in cur.fetchall():
        username, email, real_name, _ = row
        results.append((username or "", email or "", real_name or ""))

    cur.close()
    conn.close()
    return results


def print_table(results: List[Tuple[str, str, str]]) -> None:
    """Print search results as a formatted table."""
    if not results:
        print("No users found matching the search term.")
        return

    # Calculate column widths
    username_width = max(len("Username"), max(len(r[0]) for r in results))
    email_width = max(len("Email"), max(len(r[1]) for r in results))
    real_name_width = max(len("Real Name"), max(len(r[2]) for r in results))

    # Print header
    print(
        f"{'Username':<{username_width}} | {'Email':<{email_width}} | {'Real Name':<{real_name_width}}"
    )
    print(f"{'-' * username_width}-+-{'-' * email_width}-+-{'-' * real_name_width}")

    # Print rows
    for username, email, real_name in results:
        print(
            f"{username:<{username_width}} | {email:<{email_width}} | {real_name:<{real_name_width}}"
        )


def main():
    parser = argparse.ArgumentParser(
        description="Search MediaWiki users by username, email, or real name"
    )
    parser.add_argument(
        "search_term", help="Search term to match against username, email, or real name"
    )
    parser.add_argument(
        "--limit",
        "-l",
        type=int,
        default=10,
        help="Maximum number of results (default: 10)",
    )

    args = parser.parse_args()

    # Search for users
    results = search_users(args.search_term, args.limit)

    # Print results as table
    print_table(results)


if __name__ == "__main__":
    main()

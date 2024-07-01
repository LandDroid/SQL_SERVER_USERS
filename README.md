# SQL_SERVER_USERS
The script checks and drops the existing users table if present. It creates a new table with columns for user data, encrypts passwords with SHA-256, and inserts users in a transaction for reliability, rolling back on errors. Verification confirms successful user insertion.

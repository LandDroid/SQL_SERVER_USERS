# Simple SQL Server User Table with Login

This SQL script first checks if the users table exists and drops it if found. It then proceeds to create a new users table with specified columns for storing user information, including a hashed password and salt for security. Following this, it inserts a new user record with a dynamically generated salt and a SHA-256 hashed password. The entire insertion process is wrapped in a transaction to ensure atomicity and consistency, with proper error handling to rollback changes if any issues occur. Additionally, a verification step is included to confirm the successful insertion of the new user.




## Features

- Database Setup: Checks and drops existing users table if it exists.
- Table Creation: Creates a new users table with columns for username, email, password hash, and salt.
- User Insertion: Inserts a new user with a dynamically generated salt and SHA-256 hashed password.
- Transactional Integrity: Uses transactions to ensure all operations are atomic and rolled back on errors.
- Verification: Optionally verifies the successful insertion of the new user for debugging purposes.




## Usage

    1. Setup Database: Execute the provided SQL script in your SQL Server environment.

    2. Insert User: Modify variables (@username, @password, @email) in the script and run to insert a new user.

    3. Verification: Optionally execute the last SELECT statement to verify the user insertion.

``` sql 
-- Check if the users table exists
IF OBJECT_ID('users', 'U') IS NOT NULL
BEGIN
    -- Drop the users table
    DROP TABLE users;
END;
GO

-- Create the users table
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Primary key column with auto-incrementing integer values
    username NVARCHAR(50) UNIQUE NOT NULL,  -- Username column, unique and cannot be null
    email NVARCHAR(100) UNIQUE NOT NULL,  -- Email column, unique and cannot be null
    password_hash NVARCHAR(255) NOT NULL,  -- Password hash column, cannot be null
    salt NVARCHAR(255) NOT NULL  -- Salt column, cannot be null
);

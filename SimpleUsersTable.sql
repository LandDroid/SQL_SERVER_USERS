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

-- Insert a user with generated salt and hashed password
DECLARE @username NVARCHAR(50) = 'admin2';  -- Define a username variable with the value 'admin'
DECLARE @password NVARCHAR(50) = 'password2';  -- Define a password variable with the value 'password'
DECLARE @email NVARCHAR(100) = 'admin2@example.com';  -- Define an email variable with the value 'admin@example.com'

BEGIN TRY
    BEGIN TRANSACTION;

    -- Generate a salt
    DECLARE @salt NVARCHAR(255) = CONVERT(NVARCHAR(255), NEWID());  -- Generate a unique identifier and convert it to NVARCHAR(255) to be used as a salt

    -- Concatenate the password and salt, then hash the result
    DECLARE @password_hash NVARCHAR(255) = CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', @password + @salt), 1);  -- Hash the concatenated password and salt using SHA-256 and convert the result to NVARCHAR(255)

    -- Insert the new user into the users table
    INSERT INTO users (username, email, password_hash, salt)
    VALUES (@username, @email, @password_hash, @salt);  -- Insert the username, email, hashed password, and salt into the users table

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Verify the insert (optional step for debugging)
-- Select all columns from the users table where the username is 'admin'
SELECT * FROM users WHERE username = 'admin';  

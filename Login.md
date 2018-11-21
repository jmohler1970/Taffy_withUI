# Taffy for REST: Part 7 Login

We are now going to login some people. We need to change the `dbo.Users` table a bit. Lets add some columns.

# Alter script

you can find this in the db_setup directory after you do an install. You could also visit the NorthAmerica Repository listed below

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

We also have some new functions with our bean. The function is called `setPassword()`.







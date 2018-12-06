# Taffy_withToken


This code covers

* Taffy for REST - Part 5: Access Tokens with some real simple authorization
* Taffy for REST - Part 6: CAPTCHA
* Taffy for REST - Part 7: Login
* Taffy for REST - Part 8: Buefy = VueJS + Bulma
* Taffy for REST - Part 9: Buefy flavored HTML
* Taffy for REST - Part 10: VueJS + Bootstrap

# For part 8


Change server.json to:

{
    "name":"Taffy_withToken",
    "app":{
        "cfengine":"adobe@2018"
    },
    "web":{
        "http":{
            "port":8080
        },
        "welcomeFiles":"home-buefy.html"
    }
}

# Video 4


# Quick Overview

# Commandbox

None of the command box files have been updated


# Entity Updates

StatesProvinces in now Read Only

Users now has new fields

# Resource Updates

## Users

Even thought Entity has new fields we will not be sending them over

## Users_ID

Even thought Entity has new fields we will not be sending them over

## Login

This is going to be covered in this video

## Captcha

This is going to be covered in video 5. Ignore this for the time being

# config.json

This is a brand new file. Let's take a look at it

```
{
	"authorization" 			: "hawkfeedflaw",
	"hash_algorithm" 	: "SHA-384",
	"tokenSkipped" 	: ["/login", "/login/captcha"],
	"tokenExpiration" 	: 60
}
```



## First we have the apikey
APIkey provides our first round of security. It must be sent over with any and every request. It is static; it never changes. This does not provide security. It is just there to make sure the real dumb hackers can't do anything. This is a string that will be on your HTML file. It can be read and found out.

## hash_algorithm
We don't save passwords in the clear. We encrypt them. Same goes for CAPTCHA. This is to make sure that even if someone had access to the database, no passwords are compromised.

## tokenRequired
This identifies the resources that do not require the user to have a valid login token. If a new resource is added to our rest application, it will almost certainly require the user to be logged in.

## tokenExpiration
This is how long a login a token is good for in minutes.


# Application.cfc

All kinds of things to support authentication and authorization. One of the biggest is that we will be storing some configuration information into `config.json`


# Resources

- https://stackoverflow.com/tags/api-key/info


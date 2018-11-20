# Taffy for REST: Part 5 Access Tokens with some real simple authorization

This is an introduction to authorization with Taffy.

There two words that are often spoken as if they had similar meanings. One is authorization and the other is authentication. These are two very different things.

## Authorization

Authorization answers the question of whether you have permission to do something. We are going to be talking about **APIKey**, which is our first round of protecting our data

## Authentication

Authentication answers the question of figuring out who you are. Once we figure out who you are, we will them authorize you to do more. We are going to be covering that in a later video.

# APIKey

Our state/province data does not seem to have too much of a security concern, but we are moving on to storing user data. This needs to be protected. An email address out in the public is an email address that is going to get abused. We are going to be going through several layers to protect our data. APIKey is our first one.

What is an APIKey? Let's go over to the StackOverflow definition

> An application programming interface key (API key) is a code passed in by computer programs calling an API (application programming interface) to identify the calling program, its developer, or its user to the Web site. API keys are used to track and control how the API is being used, for example to prevent malicious use or abuse of the API (as defined perhaps by terms of service).

That is a good starting point. APIKey is not particular to REST or even the web.


## Good Parts

- Easy to implement
- Stops web browser access
- Can work in conjunction with other authorization techniques
- Better than nothing


## Not So Good Parts

- APIKeys can be shared by client applications and nothing can stop it
- It should be used in conjunction with other authorization techniques
- Not really that much better than nothing

# Implementation

I have updated `application.cfc` with a couple of things. I don't like mixing configuration with implementation. Consider line 17. I have added a new file called `config.json` which will hold things like APIKey. I am using the `final` keyword to indicated that this is a constant. If you are running on ColdFusion 2016 or older, this will have to be removed

On line 25 to 30, I am checking for thest existance of APIkey. If it is not there, I am return a 401 Error.

O line 32 to 37, I am checking if the string matches. If not return an error.

That's it!

# Standardizing response formats.

When I started working on this video, I was going to end it right there, but then I figured I better bring in another small topic. I want to standardize my response formats. Every time I do a request now, I could get an authorization error, or an authentication error, or a processing. I want the application consuming my REST resource to always get the same format.

So I have decided to standardized the response format to return `message`, `time`, and `data`. `message` will always have `type` and `content`.

Let's look ahead to what we are going to do with `message`. It is going to get pushed into an array, processed by a technology such as VueJS and turned into alert message. My implemenation here is Buefy. If you have never heard of Buefy that is OK, the important part of the REST webservice is that it be generic enough that any front end developer can use it as they needed. I did change my return format for Buefy; I changed it to be flexible.


# Looking at `config.json`

I am going to be doing several videos on this Github repository. `config.json` has settings for things that we haven't covered yet. Line 2 has stuff that is interesting to this video. It has the apikey. 

A short static string is not the most creative approach to APIkeys. I could imagine have a UUID and doing some database query. There are a lot of things one could do with an APIkey; this gets us started.

So we take all of `config.json` and load it into the Application scope.


# Resources

- https://stackoverflow.com/tags/api-key/info

- https://github.com/jmohler1970/Taffy_withUI

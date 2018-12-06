# Taffy for REST: Part 8 Buefy = VueJS + Bulma

We have been at this for a couple of months, so it is really exciting to finally have a functioning application to show. Everything up until now has been changes to database, changes to beans, changes to resources, changes to `application.cfc`. 

But there has been no UI to speak of; that was deliberate. There is a wall between front end and back end development. This has some consequences. We are not going to be asking ColdFusion to generate HTML. It is just going to be delivering data. The HTML has to be generated via Javascript on the frontend. There are a lot of mature technologies that do that. The application is going to be using VueJS.

# So what is a VueJS?

Let's what Stackoverflow thinks:

> VueJS is an open-source, progressive Javascript framework for building user interfaces that aim to be incrementally adoptable. ...

> VueJS provides two-way data binding, computed properties, CSS bindings, HTML templates, partial rendering and can be extended with components, mixins, and plugins.

That is a lot of stuff. My emphasis the versatity of VueJS. You can take plain HTML and make it much much smarter than you could with tinkering it with, say, jQuery. You can also use CDNs. You don't have to write or rewrite you applications like Angular would require.

The next thing I like about it, the functional reads off like checklist of things that you might want. If you understand the sections of the checklist, you can start building your applications. I learned Object Oriented programming in school a long time ago in school. In variably they talk about things like properties, methods, inheritance, and polymorphism. That is just the vocabulary of an object.

Web pages are different. The vocabularly of web pages is a bit of a mess. We say things like HTML, CSS, and Javascript. But then it get bigger and sloppier. I can talk about HTML tag ids and classes, but HTML tag ids and classes are also a part of CSS and Javascipt via the DOM. Then was is the DOM? HTML has attributes on tags but there are also `data-` which are typically Javacript only, but it could be CSS. There are CSS selectors, but jQuery even more powerful selectors than plain CSS.

The web page technology stack... Stack isn't even the right word. The web page technology Venn diagram has these overlapping circles of functionality. Each one of these technologies has libraries that focus one making their area better.

Back to objects. There are things we call objects. Javascript can have clean things we call objects. CSS classes aren't objects exactly. Their syntax resemebles objects. Javascript can tinker with them like objects. In HTML DOM stands for Document Object Model. But I would not call HTML Object Oriented.


## It is time to hit the reset button

If you are looking for a pure OO wrapper around HTML, I am telling you don't want that. What we need is a checklist. Let's take a look at the VueJS checklist that I used for my sample application. BTW this file can be found in `assets/app.js`. 

`el:`
This is probably the easiest to explain. I finds a single matching tag and attaches your application to it.


`data:`
All the properties to the application belong here. The properities and be arrays and structs as needed.


`computed:`
When data is updated, computed functions are automaticly updated as necessary. VueJS has a lot of smartitude to figure out when this happens. It will cover almost all data changes. Furthermore, its in the HTML part of your application, it is accessed via identical systax as data. This is a highly useful from the HTML side of the world because we don't expect to see function calls. It is unneeded. Just get what you need.

`methods:`

Sometimes you just need functions. Typically these will be tied to click events, but they don't have too. You can type them to lifecycle events

`mounted()`

Speaking of life cycle events. There are a lot of them. And they vary depending on how you use VueJS. I am doing the CDN approach. If you were using Vue CLI, it would have different hooks. I am using `mounted()`. `mounted()` happens after

- VueJS has been downloaded from the CDN
- VueJS javascript has been compiled by the browser
- VueJS Events and Lifecycle have been initalized
- VueJS Injections and reactivity are running
- Matching template is found
- Matching template is compiled (and does not have compile errors)

After all that, the `mounted()` function is called.


For more details:

https://vuejs.org/v2/guide/instance.html


# What about the HTML?

For this application, we have one HTML file to deal with: `home-buefy.html`. Let's learn how to read VueJS-flavored HTML. As a ColdFusion developer, I am drawn to tag that starts with `<cf`. In the Vue-flavored HTML side of the world, I am drawn to:

- `{{}}` : is going to a data or a computed property that is going to be displayed. It reminds me of `<cfoutput>` or `<cfdump>`. The curly brace format I first saw in mustache. It reminds me of that too.
- `:` : Is going to be a variable substitution into an HTML attribute. It is a bit of a strange syntax. The thing next to the colon is the attribute, the value is the name of variable being used.
- `@` : Is going to be some kind of action. It is similar to onclick or on whaterver
- `v-` attributes : This is the bread and butter of Vue. Things like `v-model`, `v-for`, `v-if` get the work done.

Working with VueJS does end here. 

We have everything that is brought in by Buefy.

# Buefy/Bulma

##So what is a Buefy?

Buefy is library that takes Bulma and add all kinds of VueJS funtionality to it. 

##So what is a Bulma?

Bulma is a responsive design library that is written exclusively in CSS. It is more modern that Bootstrap and in some ways its class names are cleaner. It is definitely smaller.

##So what is a Buefy again?

Buefy combines all the VueJS goodness with Bulma goodness and adds even more functionality. You can see its custom tags because they start with `<b-`. A good set of custom tags can really make programming quick and easy. It also means that we are dealing with HTML that really isn't HTML any more.

We have 

- real HTML
- VueJS attributes
- Bulma classes
- Buefy custom tags

All being mixed in. It is a different world from ColdFusion + HTML mix. But conceptually it is not that different.

# Looking at /assets/app.js

I have done some other videos on how to understand VueJS code. I will put links below. I am only going to talk about the highlights.

Lines 1 though 5 is where we setup our Axios connection. We will be using for all CRUD operations. You will not that apiKey is hardcoded in there. This makes it not su much of a secret. Like I have said in previous videos, this does not provide a lot of security, but it does keep our endpoint from being wide open.

Lines 8 and 9, is where we start doing VueJS code. We use this to attach VueJS to the HTML.

Line 12 through 32: takes care of all of our data in the Single Page Application or SPA. There are good parts to this approach, and not so good parts

## Good parts

- Everything we need to know is in one place.

## Not so good parts

- router holds the application state. Routers in a proper MVC application are much more sophisticated. This is scraping the bottom of the barrel on routers.
- user infomation, login state, and messages are all mixed in together. It would be better if we could isolates these. This begs for a modular approach

## Let's step back for a second.

I have been spending lots of time going over building the REST API with Taffy. For a while now I have been wanted to show a functioning application. After all what is the REST API stuff supposed to be good for? You should consider this to be a minimal User Interface to demonstrate what Taffy can do. We are no where near the end of the road with all this.

I also know that not everyone if familiar with VueJS. I suspect that only small number of people watching this video have worked with VueJS. I don't want to bring in VueJS' entire family of technologies, yet. Let's get back to the code...

## Back to the Code... Computed values er, functions

When people ask me, what do I like about VueJS, the first thing that I bring up is that it can be brough in an HTML page  AND be used with NPM.

The second thing that I bring up, is computed values. Or are they computed functions. Computed works some serious magic. Computed pays attention to all the data. Whenever data changes it automatically changes its corresponding value. Our sample here has six different functions. They are never explicity called, but they are all automatically called.

If all that wasn't cool enough, we used them as if they were values. These are all used for login validation message. I show these messages the same way I would show data.


## Methods

Unlike computed, we call methods explicity. I have three functions here; `prelogin` is the most interesting.

Line 81 uses the variable http. That came from Axios. It is not built into Javascript or VueJS.
Line 82 uses the GET verb to get the CAPTCHA image. If you watched the video on CAPTCHA, you know that I am return a base64 representation of the CAPTCHA image. As far as VueJS is concerned, it is just a string that gets assigned.

### Committing a user

One of the things that I like about VueJS, is that it does not have a lot of extra syntax. This block of code is responsible for saving a new user. Lines 27 through 31 does some mapping of variables, but not a lot else is needed.

When I was first learning this, the asyncronous aspect challenged me. When I look at Line 36 I see `.then`. What is a `.then`. There is no simple answer, so I will give the long answer.

One line 26, when we did the `.post` we also sent the processing in a separate thread. We really can't send anything back on line 39 in the `return` statement, because there is no data to return. `.then` will process after `.post`. In other words, `return` won't want for the `.post` to be done. `.then` will wait.

Inside of the `.then`, we have a function.  I still need to look twice when I see a function without a name or a function being assigned to a variable. I have to look at least three times when I see an arrow function. Once I got past then new syntax, it actually kind of clean. I could have created a normal nameless function inside the `.then`, but an arrow function is less typing. We use commas instead of semicolons inside of arrow functions. We user parenthesis instead of brackets to wrap the operations. Aside from all that, arrow functions are just functions. In this case, it contains the operations to be done after `.post` has completed what it does.


### ListUser

This is where we show all the users

On line 186, I used an error function to load all the users into `this.users`
On line 187, I switched approaches. I am not using an arrow function. I should have continued with the arrow functions. There is no need to change.


## Mounted

Mounted is one of my favorite parts of the VueJS lifecycle. It is vaguely similar to `document ready` in jQuery. By the time we get here all potential compilation problems have not happened.



# Resources

- https://coldfusion.adobe.com/2018/11/vuejs-for-coldfusion-programmers-first-10-minutes/

- https://vuejs.org/v2/guide/installation.html

- https://vuejs.org/v2/guide/instance.html


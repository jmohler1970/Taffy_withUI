# Taffy for REST: Part 8 VueJS + Bulma = Buefy

I have been at this for a couple of months, so it is really exciting to finally have a functioning application to show. Everything up until now has been changes to database, changes to beans, changes to resources, changes to `application.cfc`. 


But there has been no UI to speak of; That was deliberate. There is a wall between front end and back end developement. This has some consequences. We are not going to be asking ColdFusion to generate HTML. It is just going to be delivering data. The HTML has to be generated via Javascript on the frontend. There are a lot of mature technologies that do that. The application is going to be using VueJS.

# So what is a VueJS?

Let's what Stackoverflow thinks:

> Vue.js is an open-source, progressive Javascript framework for building user interfaces that aim to be incrementally adoptable. ...

> Vue.js provides two-way data binding, computed properties, CSS bindings, HTML templates, partial rendering and can be extended with components, mixins, and plugins.

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

I have done some other videos on how to interpret our code. I will put links below. I am only going to talk about the highlights.



















# Resources

- https://vuejs.org/v2/guide/installation.html

- https://vuejs.org/v2/guide/instance.html


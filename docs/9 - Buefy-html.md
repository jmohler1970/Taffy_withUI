# Taffy for REST - Part 9: Buefy flavored HTML

I talked a lot about Buefy in video 8, but I didn't have a chance to dive into the HTML. Rather than having a long video, I split it at the end of the `assets/app.js` discussion.

We are now on to the HTML part of the story. Let me give away the ending this part of the story if I may. I have done a lot of these videos with Bulma and Buefy and I don't really like either one of those that much. I have another video after this one where I use Bootstrap and Bootstrap-Vue instead of Bulma and Buefy. The porting of the code reveiled some interesting things. This video is going to serve as a setup for that video.


# How to spot VueJS, Bulma, and Buefy in the HTML code.

## VueJS

VueJS is the biggest and most important. If you see any of the following patterns in your HTML, you are dealing with VueJS


VueJS
`{{ }}` ie `{{login_token}}`
`v-` ie `v-model`
`@something` ie `@click`
`:something` ie `:class="showhide"`

Bulma

```
<div class="container">
	<div class="columns">
	 		<div class="column">
```

Buefy

```
<b-input
	v-model.trim="captcha"
	id="captcha"
	>
</b-input>
```

* `{{ }}` : Mustache style braces output variables. It can even output a struct or an array.
* `v-` attribute: This where all the conditional and looping logic is going to live. Variables tinkered with in `app.js`. It is pure view (v-i-e-w) logic here. The most famous of the `v-` attributes may `v-model`. That is where you get two-way binding on day
* `@something` attribute: `@click` is probably the most common. This is where you are going to respond to events such as clicks or keyboard actions. If you want to have something respond to shift right click, you can do it.
* `:something` attribute: This is where you get one-way binding. This is a strange syntax. Let me just give an example

```
<!--- In VueJS --->
<div :class="HideMe">

<!--- In ColdFusion --->
<div class="#HideMe#">
```

It is almost backwards from ColdFusion, but I think about it this way. I want my HTML to be smarter. The only way an engine like VueJS can make it smarter is by manipulating what is already there. If `:class` was never a part of the normal presentable HTML. When the HTML was parsed, it was put off to the side. Browsers don't know what a `:class` even is. VueJS comes along, parses its part of the HTML and sees something it understands. Later it can tie in the variable that is on the right side of the equals.

## Bulma

Bulma is kind of easy to find. I did not make any custom CSS `class`es or `id`s. If it looks like a `class` or an `id`, it came from Bluma.

As an aside, this is different from jQuery. With jQuery one tends to tie behavior via `class`es and `id`s. VueJS ties behaviors with custom attributes and Mustache like braces.

## Buefy

Buefy provides custom tags. If you see a tag that starts with `<b-`, it is going to be converted into HTML with Buefy.

This is where the power of a custom tag libary either shines or doesn't. I want my tag library to reduce the amount of code that I write. I later did all this with the Bootstrap-Vue library. BTW, Bootstrap dash view is different from Bootstrap and Vue. When I did the Bootstrap-Vue library, its customer tags seemed to be more powerful. I ended up writing less code.

# Now that we know

Now that we know what kind of code to look for, let's go to `home-buefy.html` and see how it turns out.

# Navbar code

Line 33: We are using the Bulma navbar. `is-info` changes it to a dark blue. Much darker than the Bootstrap equivalent

Line 36: Is going to write out an icon. The default icon pack is Material Design Icons.

Line 48: When a click happens we are going to set a variable called `router`. `router` was first seen in `assets/app.js`. It was found in the data section. Looks like this link is only shown based on some condition. You will have to look at the code to see what that condition is. Hint: if you have a login_token, you can go to the home page

Looking at the rest of the top menu...

Line 61: The @click is calling a method. No paretheses are needed
Line 62: `v-if` does exactly what you think it would do. The right hand side is the condition check. Note I had to do a "not double equals". If I did a "not equals" that would have been a comparison of objects. I wanted to do a comparison of strings.
Line 63: Is similar with the triple equals.
Line 76: How about that a `v-else` . I don't know about you, but I think that is cool


# Notifications

Line 91: `column is-one-quarter` is a Bulma thing. It is easy to read, but it has not grown on me.
Line 94: This is how you read this. `<b-notification>` is a Buefy custom tag. It is set to show icons unconditionally. `<b-notification>` is a lot like alert.
On line 95: we are going to be looping over an array of messages. We load individual messages into message, if we need a position in the array, that can be found in key. VueJS will give a warning message if you the key thing.
One line 96: It is common for custom tags to structure their attributes. It is true to say that `:type`will eventually be come a `class`, but `:type` suggests a purpose. We do a little bit of string manipulation in here too.
One line 97: I am confidant that the html in `message.content` is safe. If I did mustache like braces, it would not pass though things like bold. It would escape it. By using `v-html` my variable can pass through, markup and all

# Really bad routing

On the bottom of the page, I am doing a dump of the login token and router variables. I use this to switch waht is shown. The router is set to users, so I am showing the user table.

If I were to set it to welcome, then the welcome page content will be shown.


# Navigation

Line 36: `<b-icon>` custom tag. FYI, you can't use shortcut tags on these

Line 48: Is interesting. At first it looks like a normal `<a>`, but it does not have an `href`. It will respond to clicks via `@click`. It will not navigate way to any other page. It will just set the `router` variable. VueJS will figure out all the necessary changes to the page

If we go farther down on the nav bar code, we start seeing some common patterns.

We have three buttons of `type=button`
All three buttons have `@click` attributes. But they are not the same. We have `listUser` (a method), `logout`,  method

## Going a little farther down in the code for navigation

I am going to go way off topic. If you ever watch professional sports, you can atheletes doing the same thing over and over with ease. A lot of that is muscle memory. They have done things so many times, they don't even have think about it. It is just automatic.

I think programming has some of the same skills. Have you ever shown ColdFusion to someone who does not program in ColdFusion. It just does not register with them. They see `<cfif>` and `<cfquery>` and nothing registers. `<cfscript>` and `<script>` blend too. It is not that they can't understand it, they just don't have the eyeball memory of someone who has looked at it over and over.

In this sliver code, I have `@` attributes, `:` attributes, and `v-` attributes. The syntax highlighting isn't that good, but they start to pop if you look at them enough. Let's see...

On 61, I have a function call, but without params
On 62, The User manager button is only going to be shown some times
On 63, I am doing a string compare. The rest seem about the same
On 75, I am setting a variable to having a value.

I just did this block of code with buttons. The previous block of code used `<a>` tags. What is the difference? There is none, because I am intercepting very early. These are buttons that are not in a form, but that does not matter because I am interepting the clicks long before any kind of form would even run. These buttons are triggering `GET` or `POST`. We would have to look at `assets/app.js` to know what is going on.






# Login 

When the router is set to `prelogin` we get the login form

Buefy uses `<b-field>` and `<b-input>`

Some Logic around the login button


# Resources

- https://vuejs.org/v2/guide/events.html


- https://github.com/jmohler1970/Taffy_withUI

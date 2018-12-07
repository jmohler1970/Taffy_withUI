# Taffy for REST - Part 9: Buefy flavored HTML

I talked a lot about Buefy in video 8, but I did have a chance to dive into the HTML. Rather than having a long video, I split it at the end of `assets/app.js`

Let me give away the ending this part of the story if I may. I have done a lot of these videos with Bulma and Buefy and I don't really like either one of those that much. I have another video after this one where I use Bootstrap and Bootstrap-Vue instead of Bulma and Buefy. The porting of the code reveiled some interesting things. This video is going to serve as a setup for that video.


# How to spot VueJS, Bulma, and Buefy in the HTML code.

## VueJS

VueJS is the biggest and most important. If you see any of the following patterns in your HTML, you are dealing with VueJS

* `{{ }}` : Mustache style braces output variables. It can even output a struct or an array.
* `v-` attribute: This where all the conditional and looping logic is going to live. Variables tinkered with in `app.js`. It is pure view (v-i-e-w) logic here. The most famous of the `v-` attributes may `v-model`. That is where you get two-way binding on day
* `@something` attribute: `@click` is probably the most common. This is where you are going to respond to events such as clicks or keyboard actions. If you want to have something respont to shift right click, you can do it.
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



# Resources

- https://vuejs.org/v2/guide/events.html




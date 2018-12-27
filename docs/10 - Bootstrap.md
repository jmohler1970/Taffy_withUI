

# Introduction

## Taffy for REST: Part 10 VueJS + Bootstrap

After working with Buefy and Bulma and experiencing some of what they have to offer, I decided to make a bit of a U-turn. I was drawn to Bulma because of its CSS only approach, but Javascript got added right back in via VuaJS and Buefy. I don't see the CSS only approach as being particularly powerful. So I wandered back to Bootstrap

A similar techonology is Bootstrap Vue, Bootstrap plus Vue, and this is what I saw


- Bootstrap, in general. is **the** responsive design library. It is everywhere.
- Bootswatch provides lots of free themes for Bootstrap. Not every Bootstrap website has too look the same going out the door
- The Bootstrap Vue library is much more complete than Buefy
- The code is noticably smaller. My sample code is 330 lines vs 410 lines. About 20% smaller.
- Buefy does not have a killer feature. It does not have anything that I have been able to find that screams "Do this! do this!"
- Lastly, I have worked with Bootstrap continuously since version 2. I want to keep building on that skillset.


In order to use Bootstrap Vue, I did not have to change `assets/app.js` nor did I have to change my Taffy powered web services. Migration was very simple.

With that,Bootstrap Vue it shall be.

# Some Cool lines of code

These sample projects have gotten so large, I don't want to cover every line of code, just the interesting stuff. The thing that I don't like about Bootstrap is how it uses `<div>` s. It is not unheard of to see `<div>`s nested eight layers deep. You end up having a bunch of `</div>`s, but there is no real clear way of knowing what exactly it ended. Buefy did a little to fix this, but Bootstrap Vue goes after that problem with a vengance. I get all the way down to line 47 and I didn't have any `</div>`s. This is already more readable.

In the container where we take care of the alerts, all the custom tags are identical to the Boostrap class names, so it is easy to tie the two concepts together

On line 95, I cleaned up how I handle form controls. There is no name, and no id. I am just tying the two together with `v-model.trim="email"`

The `b-button` on does not even any overrides. Oddly enough, Buefy abstracts icons, whereas Bootstrap Vue does not. I I wanted to, I could add a `:class` to the `<i>` tag if I needed it to be more interactive, but it is fine as it is. 

# Going off on a Tangent

I was going to fill the rest of this video with "Here is how Buefy does, it here is Bootstrap Vue doing it better". I am going to go down a very road

# Why we need bundlers

Let's take a look at all the JS files that we are pulling in. Currently we are at five

- VueJS
- Polyfill
- Bootstrap Vue
- Axios
- and my own `assets/app.js`

I did not do a built out of a proper router and I am not modularizing my code. To do those, I would need

- Vue Router and
- Vuex

I am asking the web browser to do too much client side assembly. If I do this on the server, I get all kinds of good things

- I get a structure. Rather than starting with plain HTML, I have a plan. When I did the REST webservice, I liked that Taffy gave me an approach
- Javascript is good, but how about TypeScript?
- I can debug locally.

# Now for the sad part

Now for the sad part. When I first started developing, ColdFusion took care of the entire technology stack. It connected to the database; it looped over the results; it generated the HTML. I have done that for years. More years than I want to admit. But let us consider the context of why that was done.

Web browsers were really horrible. Javascript was even worse. There is a reason why jQuery is used on 80% of all public facing sites. Bridging over browser differences was a huge gap that needed to be smoothed over. ColdFusion had a big role too. It pushed out lots of HTML, no javascript needed. It got the job done. 

We are in a different place now. We **can** expect browsers to pull in a lot of data via JSON. ColdFusion is still delivering the data for a wide variety of sources. It just doesn't have to do all the work in displaying the data. And that is a good part.


# Resources

- https://bootstrap-vue.js.org/
- https://www.bootswatch.com






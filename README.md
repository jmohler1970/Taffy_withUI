# Taffy_withToken


This code covers

* Taffy for REST - Part 5: Access Tokens with some real simple authorization
* Taffy for REST - Part 6: CAPTCHA
* Taffy for REST - Part 7: Login
* Taffy for REST - Part 8: Buefy = VueJS + Bulma
* Taffy for REST - Part 9: Buefy flavored HTML
* Taffy for REST - Part 10: VueJS + Bootstrap

Documentation can be found in ./docs


## Tinkering

For part 9


Change server.json to:

```
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
````

For part 10, change `welcomeFiles` to `home-bootstrap-vue.html`




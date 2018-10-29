const http = axios.create({
	baseURL: 'index.cfm?endpoint=/',
	timeout: 1000,
	headers: {'apiKey': 'hawkfeedflaw'}
	});


new Vue({
	el: '#app',

	data () {
		return {
			messages 		: [],
			users 		: [],

			email 		: '',
			password 		: '',
			captcha_image 	: '',
			captcha_hash 	: '',
			captcha 		: ''
			};
		},



	computed: {

		invalidEmail(){
			if (this.email.length == 0)			{ return 'Enter an email' 					}
			else if (this.email.length <= 4)		{ return 'This is too short to be a valid email'	}
			else if (!this.email.includes("@"))	{ return 'Email must include an @'				}
			else 							{ return '' 								}
			},

		stateEmail()	{ 
			if (this.email.length == 0) return "";
			return (this.email.includes("@") && this.email.length) > 4 ? "is-success" : "is-danger"
			},


		invalidPassword()	{
			if (this.password.length > 4)			{ return '' 						}
			else if (this.password.length > 0)		{ return 'Enter at least 4 characters'	}
			else 							{ return '' 						}
			},

		statePassword()	{ return this.password.length >= 4 ? "is-success" : "is-danger" },


		invalidCaptcha()	{
			if (this.captcha.length > 4)			{ return '' 						}
			else if (this.captcha.length > 0)		{ return 'Enter at least 4 characters'	}
			else 							{ return 'Enter the characters/numbers displayed in the image above.' 		}
			},

		stateCaptcha()	{ 
			if (this.captcha.length == 0) return "";
			return this.captcha.length >= 4 ? "is-success" : "is-danger" }
		},

	mounted(){
		this.go();
		},

	methods :	{
		go : function() {http
				.get("login/captcha")
				.then(res => {this.captcha_image = res.data.captcha_image, this.captcha_hash = res.data.captcha_hash})
				.catch(function (error) { console.log(error); })
				;

			},

		submit : function()	{
			http
				.post("login", { email : this.email, captcha : this.captcha, captcha_hash : this.captcha_hash })
				.then(res => (this.messages = res.data.messages))
				.catch(function (error) { console.log(error.response); })
				;
			}

		} // end methods

	});
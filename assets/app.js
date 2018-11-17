const http = axios.create({
	baseURL: 'index.cfm?endpoint=/',
	timeout: 1000,
	headers: {'authorization': 'hawkfeedflaw'}
	});


new Vue({
	el: '#app',

	data () {
		return {
			statesprovinces : [],

			router		: "welcome", // not a real router
			messages 		: [{"type" : "success", "content" : "<b>Success:</b> VueJS is running and is active"}],
			users 		: [],
			user 		: {id : ""},

			fields		: [ // bootstrap only
				"id", "firstName", "lastName", "email", "stateProvinceId", "deleted"
				],


			userModal		: {"title" : "Add User", "actionLabel" : "Add"},

			email 		: '',
			password 		: '',
			captcha_image 	: '',
			captcha_hash 	: '',
			captcha 		: '',

			login_token	: ''
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
			if (this.password.length >= 4)		{ return '' 						}
			else if (this.password.length > 0)		{ return 'Enter at least 4 characters'	}
			else 							{ return '' 						}
		},

		statePassword()	{ return this.password.length >= 4 ? "is-success" : "is-danger" },


		invalidCaptcha()	{
			if (this.captcha.length > 4)			{ return '' 						}
			else if (this.captcha.length > 0)		{ return 'Enter at least 4 characters'	}
			else 							{ return 'Enter the characters/numbers displayed in the image above.' }
		},

		stateCaptcha()	{ 
			if (this.captcha.length == 0) return "";
			return this.captcha.length >= 4 ? "is-success" : "is-danger"
		}
	},

	mounted(){

		http
			.get("statesprovinces")
			.then(res => {this.statesprovinces = res.data.data})
			.catch(function (error) { console.log(error); })
		;


		this.prelogin();
	},


	methods :	{

		clearMessages : function()	{
			this.messages = [];
		},


		prelogin : function() {
			http
				.get("login/captcha&complexity=low")
				.then(res => {this.captcha_image = res.data.data.captcha_image, this.captcha_hash = res.data.data.captcha_hash})
				.catch(function (error) { console.log(error); })
			;
			this.router = "prelogin";
		},

		logout : function()	{
			this.login_token = "";
			this.router = "welcome";
			this.messages = [{"type" : "warning", "content" : "<b>Warning:</b> You haved logged out."}]
		},

		login : function()	{
			console.log("Doing a login with " + this.password);
			http
				.post("login", { email : this.email, password : this.password, captcha : this.captcha, captcha_hash : this.captcha_hash })
				.then(res => (
					this.messages = [res.data.message],
					res.data.data !== "" ? this.login_token = "Bearer " + res.data.data : "",
					res.data.data !== "" ? this.router = "landing" : this.router = "prelogin"
					)
				)
				.catch(function (error) { console.log(error.response); })
			;

			this.password = "";
		},

		// User series
		preAddUser : function() {
			this.user = { id : "" };
			this.router = 'usermodal';
		},

		commitUser : function() {

			if(this.user.id === "")	{
				http
					.post("users", {
						"firstName"	: this.user.firstName 	,
						"lastName"	: this.user.lastName 	,
						"stateProvinceId" : this.user.stateProvinceId,
						"email"		: this.user.email 		,
						"password"	: this.user.password 
						},

						{ headers : {"authorization" : this.login_token }}
					)
					.then(res => (this.messages = [res.data.message], this.users = res.data.data))
					;

				return;
			}

			// update
			http
				.put("users/" + this.user.id, {
					"firstName"	: this.user.firstName 	,
					"lastName"	: this.user.lastName 	,
					"stateProvinceId" : this.user.stateProvinceId,
					"email"		: this.user.email 		,
					"password"	: this.user.password 
					},
					{ headers : {"authorization" : this.login_token }}
				)
				.then(res => (this.messages = [res.data.message], this.users = res.data.data))
				;
		},


		delUser : function (id) {
			http
				.delete("users/" + this.user.id, { headers : {"authorization" : this.login_token }})
				.then(res => (this.users = res.data.data))
				;
		},

		preEditUser : function (id)	{

			this.userModal	= {"title" : "Edit User", "actionLabel" : "Save"};


			// We expect this.user.id to be populated
			http
				.get("users/" + id, { headers : {"authorization" : this.login_token }})
				.then(res => (this.user = res.data.data))
				;

				this.router = 'usermodal';
		},


		listUser : function()	{
			this.router = 'users';
			this.messages = [];
			console.log("Doing a get User");
			http
				.get("users", { headers : {"authorization" : this.login_token }})
				.then(res => (this.users = res.data.data ))
				.catch(function (error) { console.log(error.response); })
			;
		}

	} // end methods

});
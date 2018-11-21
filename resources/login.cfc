component extends="taffy.core.resource" taffy_uri="/login" {

// make sure this function goes away. It only exists to setup initial user in DB
function put(required string password)	{
	return rep({
		'message' : { 'type' : 'success' },
		'time' : GetHttpTimeString(now()),
		"data" : hash(arguments.password, application.Config.hash_algorithm)
	});
}


function post(required string email, required string password, required string captcha, required string captcha_hash){

	
	if (hash(arguments.captcha, application.Config.hash_algorithm) != arguments.captcha_hash)	{
		return rep({
			"message" : { 'type' : 'error', 'content' : 'CAPTCHA failed' },
			'time' : GetHttpTimeString(now()),
			'data' : ""
			}).withStatus(404);
		}

	variables.password = arguments.password; // wish I didn't have to do this
	// hoping for an array with one element
	var User = entityLoad("Users", {email : arguments.email}).filter(
		function(item){
			return item.validatePassword(variables.password);
		});
	variables.password = "";


	if(isNull(User) || arrayIsEmpty(User))	{
		return rep({
			'message' : {
				'type' : 'error',
				'content' : '<b>Error:</b> Email/Password is not valid. There were #User.len()# matches'
			},
			'time' : GetHttpTimeString(now()),
			'data' : ""
			
			}).withStatus(401);
		}

	var loginToken = createUUID();

	User[1].setLoginToken(loginToken)
		.setTokenCreateDate(now());
	EntitySave(User[1]);

	return rep({
		'message' : {
			'type' : 'success', 
			'content' : '<b>Success:</b> You have logged in.'
			},
		'time' : GetHttpTimeString(now()),
		'data' : loginToken
		});
	}

}

//Oct 29 loginToken: 9CC770B2-A62A-BEF0-7132C353C8483865
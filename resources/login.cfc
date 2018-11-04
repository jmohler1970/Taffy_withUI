component extends="taffy.core.resource" taffy_uri="/login" {

// make sure this function goes away. It only exists to setup initial user in DB
function put(required string password)	{
	return rep({ "passhash" : hash(arguments.password, application.Config.hash_algorithm) });
}


function post(required string email, required string password, required string captcha, required string captcha_hash){


	// remove this code once system is up and running
	var User = entityLoad("Users", {email : arguments.email}, true);

	/*
	if (hash(arguments.captcha, application.Config.hash_algorithm) != arguments.captcha_hash)	{
		return rep({'status' : 'failure', 'time' : GetHttpTimeString(now()) 	}).withStatus(404);
		}

	var User = entityLoad("Users", {email : arguments.email, passhash = hash(arguments.password, application.Config.hash_algorithm)}, true );
	*/

	if(isNull(User))	{
		return rep({
			'message' : {
				'status' : 'error',
				'message' : '<b>Error:</b> Email/Password is not valid. There were #User.len()# matches'
			},
			'time' : GetHttpTimeString(now())
			
			}).withStatus(401);
		}

	var loginToken = createUUID();

	User.setLoginToken(loginToken)
		.setTokenCreateDate(now());
	EntitySave(User);

	return rep({
		'message' : {
			'status' : 'success', 
			'message' : '<b>Success:</b> You have logged in.'
			},
		'time' : GetHttpTimeString(now()),
		'data' : loginToken
		});
	}

}

//Oct 29 loginToken: 9CC770B2-A62A-BEF0-7132C353C8483865
component extends="taffy.core.resource" taffy_uri="/login" {

// make sure this function goes away. It only exists to setup initial user in DB
function put(required string password)	{
	return rep({ "passhash" : hash(arguments.password, application.Config.hash_algorithm) });
}


function post(required string email, required string password){

	var User = entityLoad("Users", {email : arguments.email, password = hash(arguments.password, application.Config.hash_algorithm)}, true );

	if(isNull(User))	{
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : ['<b>Error:</b> Email/Password is not valid.']
			}).withStatus(401);
		}

	var loginToken = createUUID();

	User.setLoginToken(loginToken);
	EntitySave(User);

	return rep({ "loginToken" : loginToken });
	}

}

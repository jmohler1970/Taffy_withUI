component extends="taffy.core.api"  {

this.name = "taffy_21";
this.applicationTimeout 		= createTimeSpan(0, 4, 0, 0);
this.applicationManagement 	= true;

this.ormenabled = true;
this.ormsettings.eventhandling = true;
this.datasource = "UserManager";


this.mappings['/resources'] 	= expandPath('./resources');
this.mappings['/taffy'] 		= expandPath('./taffy');

function onApplicationStart() output="false"	{

	final application.Config = DeserializeJSON(FileRead(expandPath("./config.json"))); // If config.json is invalid, you are in big trouble

	return super.onApplicationStart();
	}


function onTaffyRequest(verb, cfc, requestArguments, mimeExt, headers, methodMetaData, matchedURI)	{

	if(!arguments.headers.keyExists("apiKey")){
		return rep({
			'status' 	: 'error',
			'time' 	: GetHttpTimeString(now()),
			'message_i18n' : 'KILL_CANT_CONTINUE',
			'message' : '<b>Error:</b> Missing header apiKey.'
			}).withStatus(401);
	}

	if (arguments.headers.apiKey != application.Config.apiKey) {
		return rep({
			'status' 	: 'error',
			'time' 	: GetHttpTimeString(now()),
			'message_i18n' : 'KILL_CANT_CONTINUE',
			'message' : '<b>Error:</b> apiKey is invalid.'
			}).withStatus(401);
	}

	// I need a login token and I don't have it.
	if (application.config.loginTokenRequired.findNoCase(arguments.matchedURI) && !arguments.headers.keyExists("authorization"))	{
		return rep({
			'status' 	: 'error',
			'time' 	: GetHttpTimeString(now()),
			'message_i18n' : 'KILL_CANT_CONTINUE',
			'message' : '<b>Error:</b> You must provide an authorization header to perform this operation.'
			}).withStatus(403);
	}

	

	// I need a login token and the current one is expired.
	if (application.config.loginTokenRequired.findNoCase(arguments.matchedURI))	{

		// I need a login token and I don't have it.
		if (arguments.headers.authorization == "" || listfirst(arguments.headers.authorization, " ") != "bearer")	{
		return rep({
			'status' 	: 'error',
			'time' 	: GetHttpTimeString(now()),
			'message_i18n' : 'KILL_CANT_CONTINUE',
			'message' : '<b>Error:</b> You must provide a authorization header that is not blank and starts with Bearer.'
			}).withStatus(403);
		}

		var Login = EntityLoad("Users", { loginToken : listrest(arguments.headers.authorization, " ") }, true);

		if (isNull(Login))	{
			return rep({
				'status' 	: 'error',
				'time' 	: GetHttpTimeString(now()),
				'message_i18n' : 'KILL_CANT_CONTINUE',
				'message' : '<b>Error:</b> You must provide a authorization that is valid.'
				}).withStatus(401);
		}

		// comparing my minutes
		if (Login.getTokenCreateDate().add("n", application.config.TokenExpiration).compare(now(), "n") < 0 )	{
			return rep({
				'status' 	: 'error',
				'time' 	: GetHttpTimeString(now()),
				'message_i18n' : 'KILL_CANT_CONTINUE',
				'message' : '<b>Error:</b> Your token has expired. Login again.'
				}).withStatus(403);
		}
	}

	return true;
}
}

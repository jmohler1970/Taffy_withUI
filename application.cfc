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

	if(!arguments.headers.keyExists("authorization")){
		return rep({
			'message' : { 'type' 	: 'error', 'content' : '<b>Error:</b> Missing header authorization.' },
			'time' 	: GetHttpTimeString(now())
			}).withStatus(401);
	}

	if (arguments.headers.authorization != application.Config.authorization) {
		return rep({
			'message' : {'type' 	: 'error', 'content' :  '<b>Error:</b> authorization is invalid.'},
			'time' 	: GetHttpTimeString(now())
			}).withStatus(401);
	}

	// I need a login token and I don't have it.
	if (!application.config.Token.NotRequired.findNoCase(arguments.matchedURI) && !arguments.headers.keyExists("authorization"))	{
		return rep({
			'message' : {'type' 	: 'error', 'content' : '<b>Error:</b> You must provide an authorization header to perform this operation.' },
			'time' 	: GetHttpTimeString(now())
			}).withStatus(403);
	}

	

	// I need a login token and the current one is expired.
	if (!application.config.token.NotRequired.findNoCase(arguments.matchedURI))	{

		// I need a login token and I don't have it.
		if (arguments.headers.authorization == "" || listfirst(arguments.headers.authorization, " ") != "Bearer")	{
		return rep({
			'message' : {'type' 	: 'error', 'content' : '<b>Error:</b> You must provide a authorization header that is not blank and starts with Bearer.' },
			'time' 	: GetHttpTimeString(now())
			}).withStatus(403);
		}

		var Login = EntityLoad("Users", { loginToken : listrest(arguments.headers.authorization, " ") }, true);

		if (isNull(Login))	{
			return rep({
				'message' : {'type' 	: 'error', 'content' : '<b>Error:</b> You must provide a authorization that is valid.' },
				'time' 	: GetHttpTimeString(now())
				}).withStatus(401);
		}

		// comparing my minutes
		if (Login.getTokenCreateDate().add("n", application.config.Token.Expiration).compare(now(), "n") < 0 )	{
			return rep({
				'message' : {'type' 	: 'error', 'content' : '<b>Error:</b> Your token has expired. Login again.'},
				'time' 	: GetHttpTimeString(now())
				}).withStatus(403);
		}
	}

	return true;
}
}

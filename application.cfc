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

	application.Util = new formutils.FormUtils().init();

	return super.onApplicationStart();
	}


function onTaffyRequest(verb, cfc, requestArguments, mimeExt, headers, methodMetaData, matchedURI)	{

	application.util.buildFormCollections(form);


	if(!arguments.headers.keyExists("apiKey")){
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : '<b>Error:</b> Missing header apiKey.'
			}).withStatus(401);
	}

	if (arguments.headers.apiKey != application.Config.apiKey) {
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : '<b>Error:</b> apiKey is invalid.'
			}).withStatus(401);
	}

	// I need a login token and I don't have it.
	if (application.config.loginTokenRequired.findNoCase(arguments.matchedURI) && !arguments.headers.keyExists("loginToken"))	{
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : '<b>Error:</b> You must provide a loginToken to perform this operation. Headers: #arguments.headers.keyList()#'
			}).withStatus(403);
	}

	

	// I need a login token and the current one is expired.
	if (application.config.loginTokenRequired.findNoCase(arguments.matchedURI))	{

		// I need a login token and I don't have it.
		if (arguments.headers.loginToken == "")	{
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : '<b>Error:</b> You must provide a loginToken that is not blank.'
			}).withStatus(403);
		}

		var Login = EntityLoad("Users", { loginToken : arguments.headers.loginToken }, true);

		if (isNull(Login))	{
			return rep(
				{'status' : 'error','time' : GetHttpTimeString(now()),
				'messages' : '<b>Error:</b> You must provide a loginToken that is valid. #arguments.headers.loginToken#'
				}).withStatus(401);
		}

		// comparing my minutes
		if (Login.getTokenCreateDate().add("n", application.config.TokenExpiration).compare(now(), "n") < 0 )	{
			return rep(
				{'status' : 'error','time' : GetHttpTimeString(now()),
				'messages' : ['<b>Error:</b> Your token has expired. Login again.']
				}).withStatus(403);
		}
	}

	return true;
}
}

<cfscript>
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
			'messages' : ['<b>Error:</b> Missing header apiKey.']
			}).withStatus(401);
	}

	if (arguments.headers.apiKey != application.Config.apiKey) {
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : ['<b>Error:</b> apiKey is invalid.']
			}).withStatus(401);
	}

	if (application.config.loginTokenRequired.findNoCase(arguments.matchedURI))	{
		return rep(
			{'status' : 'error','time' : GetHttpTimeString(now()),
			'messages' : ['<b>Error:</b> You must provide a loginToken to perform this operation.']
			}).withStatus(403);

	}

	return rep({"matchedURI" : arguments.matchedURI});

	//api key found and is valid
}
}


</cfscript>

component extends="taffy.core.resource" taffy_uri="/users" {

function get(string stateprovinceid = ""){

	var Users = EntityLoad("Users", {}, "ID")

	var Result = [];
	for (var User in Users)	{
		Result.append({
			"id"			: User.getId(),	
			"firstName" 	: User.getFirstName(),
			"lastName" 	: User.getLastName(),
			"email"		: User.getEmail(),
			"stateProvinceId" : User.getStateProvince().getId(),
			"deleted"		: User.getDeleted()
			});
		}
	return rep({
		'time' : GetHttpTimeString(now()),
		'data' : Result
		});
	}


function post(
	required string firstname, 
	required string lastname,
	required string email,
	required string password,
	required string stateprovinceid
	) {

	var StateProvince = entityLoadByPK("StatesProvinces", arguments.stateprovinceid);

	if (isNull(StateProvince)) {
		return rep({
			'message' : {'type' : 'error', 'content' : '<b>Error:</b> Invalid State/Province.'},
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
		}

	if (arguments.password == "") {
		return rep({
			'message' : {'type' : 'error', 'content' : '<b>Error:</b> Password is required and must not be blank.'},
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
		}

	var TestUser = EntityLoad("Users", { email : arguments.email, passhash : hash(arguments.email, application.Config.hash_algorithm) });

	if (!isNull(TestUser)) {
		return rep({
			message : {'type' : 'error', 'content' : '<b>Error:</b> Email / Password combination has already been taken.'},
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
		}

	
	var User = EntityNew("Users", {
			firstname : arguments.firstname, 
			lastname : arguments.lastname, 
			email : arguments.email, 
			stateprovince : StateProvince
			});
	User.setPassword(arguments.password);
	EntitySave(User);
	ORMFlush();

	return rep({
		'message' : {'type' : 'success', 'content' : '<b>Success:</b> User has been created.'},
		'time' : GetHttpTimeString(now())
		});
	}

}


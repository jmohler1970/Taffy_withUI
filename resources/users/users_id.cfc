component extends="taffy.core.resource" taffy_uri="/users/{id}" {

function get(required numeric id) {

	var User = EntityLoadByPK("Users", arguments.id);

	if (isNull(User))	{
		return rep({
			'message' : {'type' : 'error', 'content' : '<b>Error:</b> Unable to find User.'},
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
	}

	return rep({
			'time' : GetHttpTimeString(now()),
			'data' :	{
				"id"			: User.getId(),	
				"firstName" 	: User.getFirstName(),
				"lastName" 	: User.getLastName(),
				"email"		: User.getEmail(),
				"stateProvinceId" : User.getStateProvince().getId(),
				"deleted"		: User.getDeleted()
			}
	});
}


function put(required numeric id,
	required string firstname,
	required string lastname,
	required string email,
	required string password,
	required string stateprovinceid){

	var User = EntityLoadByPK("Users", arguments.id);

	if (isNull(User))	{
		return rep(
			'message' : {'status' : 'error', 'content' : '<b>Error:</b> Unable to find User.' },
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
	}

	var StateProvince = entityLoadByPK("StatesProvinces", arguments.stateprovinceid);

	if (isNull(StateProvince))	{
		return rep({
			'message' : {'status' : 'error', 'content' : '<b>Error:</b> Invalid State/Province.' },
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
	}

	// I wish there was a way to test passhash in a cleaner way
	var TestUser = EntityLoad("Users", { email : arguments.email, passhash : hash(arguments.email) });

	if (!isNull(TestUser)) {
		return rep({
			'message' : {'status' : 'error', 'content' : '<b>Error:</b> Email / Password combination has already been taken.' },
			'time' : GetHttpTimeString(now())
			}).withStatus(401);
	}

	var User = EntityLoadByPK("Users", arguments.id)
				.setFirstname(arguments.firstname)
				.setLastname(arguments.lastname)
				.setEmail(arguments.email)
				.setStateProvince(StateProvince);

	// If the password is blank, that must mean we are not resetting it
	if (arguments.password != "")	{
		User.setPassword(arguments.password);
	}

	EntitySave(User);

	return rep({
		'message' : {'type' : 'success', 'message' : '<b>Success:</b> User has been saved.'},
		'time' : GetHttpTimeString(now())
		}).withStatus(201);
}


function delete(required numeric id){

	var User = EntityLoadByPK("Users", arguments.id);

	if (isNull(User))	{
		return noData();
		}

	EntitySave(
		User.setDeleted(true)
		);

	return rep({
		'message' : {'type' : 'success', 'message' : '<b>Success:</b> User has been deleted.'},
		'time' : GetHttpTimeString(now())
		});

	}


}
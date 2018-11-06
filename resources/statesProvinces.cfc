component extends="taffy.core.resource" taffy_uri="/statesprovinces" {

function get(){

	return rep({
		'time' : GetHttpTimeString(now()),
		'data' : queryToArray(EntityToQuery(EntityLoad("StatesProvinces", { Country = 'USA' }, "CountrySort, LongName")))
		});
	}

}

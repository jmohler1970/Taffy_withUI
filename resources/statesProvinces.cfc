component extends="taffy.core.resource" taffy_uri="/stateprovince" {

function get(){

	return rep(queryToArray(
		EntityToQuery(EntityLoad("StatesProvinces", { Country = 'USA' }, "CountrySort, LongName"))
		));
	}

}

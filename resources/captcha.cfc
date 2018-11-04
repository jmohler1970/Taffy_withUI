component extends="taffy.core.resource" taffy_uri="/login/captcha" {



function get(string complexity = "low") {

	var CAPTCHAConf = application.Config.CAPTCHA;

	var captcha = "";

	for (var sliceLength in CAPTCHAConf.slices)	{
		captcha	&= CAPTCHAConf.data.mid(randrange(1, len(CAPTCHAConf.data) - sliceLength), sliceLength);
	}


	// This is ColdFusion
	var tempFile = "ram:///#captcha#.txt";

	var myImage = ImageCreateCaptcha(120, 360, captcha, arguments.complexity, "sansserif", 30);

	ImageWriteBase64(myImage, tempFile, "png", true, true);

	var myfile = FileRead(tempFile);
	FileDelete(tempFile);


	return rep({
		'time' : GetHttpTimeString(now()),
		'data' : {
			'captcha_hash' : hash(captcha, application.Config.hash_algorithm),
			'captcha_image' : myFile
			}
		});
}

// This is just for testing purposes
function post(required string captcha, required string captcha_hash) hint="verifies results. It is more common to tied this in with contactus or resetpassword" {

	if (hash(arguments.captcha, application.Config.hash_algorithm) != arguments.captcha_hash)	{
		return rep({
			'message' : { 'type' : 'failure', 'content' : '<b>Failure</b>: CAPTCHA respone does not match' },
			'time' : GetHttpTimeString(now())
		}).withStatus(404);
	}

	return rep({
		message : {'type' : 'success', 'content' : 'CAPTCHA is valid' },
		'time' : GetHttpTimeString(now())
		});
}

} // end component

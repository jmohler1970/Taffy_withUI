component extends="taffy.core.resource" taffy_uri="/login/captcha" {

function get() {

	var captcha	= CreateUUID().right(4) & DayOfWeekAsString(DayOfWeek(now())).left(1).lcase() & "!";

	// This is ColdFusion
	var tempFile = "ram:///#captcha#.txt";

	var myImage = ImageCreateCaptcha(100, 300, captcha, "low");

	ImageWriteBase64(myImage, tempFile, "png", true, true);

	var myfile = FileRead(tempFile);
	FileDelete(tempFile);


	return rep({'status' : 'success', 'time' : GetHttpTimeString(now()),
		'captcha_hash' : hash(captcha, application.Config.hash_algorithm), 'captcha_image' : myFile
		});
	}

// This is just for testing purposes
function post(required string captcha, required string captcha_hash) hint="verifies results. It is more common to tied this in with contactus or resetpassword" {

	if (hash(arguments.captcha) != arguments.captcha_hash)	{
		return rep({'status' : 'failure', 'time' : GetHttpTimeString(now()) 	}).withStatus(404);
		}

	return rep({'status' : 'success',  'time' : GetHttpTimeString(now()) });
	}
}

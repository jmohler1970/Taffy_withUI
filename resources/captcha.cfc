component extends="taffy.core.resource" taffy_uri="/login/captcha" {



function get(string complexity = "low") {

	var captcha	= application.Config.CAPTCHA.mid(randrange(1, len(application.Config.CAPTCHA) - 4), 3)
				& application.Config.CAPTCHA.mid(randrange(1, len(application.Config.CAPTCHA) - 4), 3);


	// This is ColdFusion
	var tempFile = "ram:///#captcha#.txt";

	var myImage = ImageCreateCaptcha(100, 300, captcha, arguments.complexity);

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

	if (hash(arguments.captcha) != arguments.captcha_hash)	{
		return rep({'status' : 'failure', 'time' : GetHttpTimeString(now()) 	}).withStatus(404);
		}

	return rep({
		message : {'type' : 'success', 'content' : 'CAPTCHA is valid' },
		'time' : GetHttpTimeString(now())
		});
	}
}

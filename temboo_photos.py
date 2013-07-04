import os, time
from temboo.core.session import TembooSession
from temboo.Library.Tumblr.CreatePhotoPostWithImageFile import CreatePhotoPostWithImageFile

session = TembooSession(TEMBOO_USERNAME, TEMBOO_APP_KEY_NAME, TEMBOO_APP_KEY_KEY)

def pngInDir():
	for filename in os.listdir('.'):
		if filename.endswith('.png'):
			print("found file " + filename)
			return filename
	return False

def sendPhoto(filename):
	createPhotoPostWithImageFileChoreo = CreatePhotoPostWithImageFile(session)
	createPhotoPostWithImageFileInputs = createPhotoPostWithImageFileChoreo.new_input_set()
	createPhotoPostWithImageFileInputs.set_Data(open(filename, "rb").read().encode("base64"))
	createPhotoPostWithImageFileInputs.set_APIKey(TUMBLR_APP_CLIENT_KEY)
	createPhotoPostWithImageFileInputs.set_AccessToken(TUMBLR_OAUTH_ACCESS_TOKEN)
	createPhotoPostWithImageFileInputs.set_AccessTokenSecret(TUMBLR_OAUTH_ACCESS_TOKEN_SECRET)
	createPhotoPostWithImageFileInputs.set_SecretKey(TUMBLR_APP_CLIENT_SECRET)
	createPhotoPostWithImageFileInputs.set_BaseHostname(TUMBLR_BLOG_HOSTNAME)#ie "smoochbooth.tumblr.com"
	createPhotoPostWithImageFileInputs.set_Tags("arthackday,arthack,largerthanlife")

	# Execute choreo
	createPhotoPostWithImageFileResults = createPhotoPostWithImageFileChoreo.execute_with_results(createPhotoPostWithImageFileInputs)

while True:
	filename = pngInDir()
	if filename:
		#uploadPhoto(filename)
		sendPhoto(filename)
		print("uploaded")
		os.remove(filename)
		print("removed")
	time.sleep(5);

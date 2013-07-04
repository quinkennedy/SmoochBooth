#SmoochBooth
**by Quin Kennedy**, created initially during [_Art Hack Day - God Mode_](http://arthackday.net/god_mode/) at 319 Scholes



###Description
There are 2 parts to SmoochBooth:
1. A processing app that takes a photo when the spacebar is pressed (which we actuated with a makey makey)
2. A python script that uploads saved photos to Tumblr

The processing app was written to take an HD feed from a webcam, and when the spacebar is pressed it does the following:
1. Turns the screen white to act as a "flash" (a la Photobooth)
2. Captures the most recent frame from the webcam
3. Saves the captured frame to disk
4. Displays the captured frame for ~10 seconds

The python script was written to periodically see if there are new .png files in a specific directory,
and upload them to Tumblr using Temboo.

###Setup
In order to set up to use Temboo to post to Tumblr:
1. Go to http://www.tumblr.com/oauth/apps and register an application
2. Sign up at https://temboo.com/ and download the Python SDK (place it in the root dir of this repo)
3. Under the 'Library' tab, find 'Tumblr' -> 'OAuth' -> 'InitializeOAuth'
4. Make sure 'Run Mode' is turned on
5. Enter your temboo account name (user name), the Tumblr Application's OAuth Consumer Key, the AppKeyName (probably myFirstApp, can be found under 'My Account' on the Temboo site, 'Application Keys' section), the AppKeyValue, and the Tumblr Application's OAuth Consumer Secret.
6. Click 'try it out'
7. In a new tab, visit the URL returned in the 'AuthorizationURL' box and click 'Allow'
8. In a new tab go to 'Tumblr' -> 'OAuth' -> 'FinalizeOAuth'
9. Fill in the first boxes the same as the InitializeOAuth page, and copy 'CallbackID' and 'OAuthTokenSecret' from the Initialize response. click 'try it out'
10. Take all that same info and enter it in the appropriate places for Temboo authentication in temboo_photos.py. Use the AccessToken and AccessTokenSecret that are returned on the 'Finalize..' page.

Now, when you run both the processing App and the python App, when you take a photo, it should save a picture in the App's root directory and then the Python script will pick up that file and use Temboo to post it to Tumblr.

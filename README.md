## Web_Application_for_Image_Search

### This is a web application to supoort Non-English to English Flickr image search.

#### The whole work process of this image search engine is: 
Firstly, the user selects the type of the language and enters search query;
Then engine uses Bing translator to translate query into English;
Engine uses translated query to get related images and their associated information through Flickr;
And then using Bing translator again to translate images' information back to the specified language;
Finally engine will present these images with details.

#### For image searching:
I use translated query and number of images as input to call Flickr API's search method. Then sending http request to Flickr and parsing XML data.

#### In image presented webpage:
I use a list to present all thembnail images and the ThumbnailGridExpandingPreview javascript library to provide big image preview function. Also the 'addmore' function is integrated to get more image results by using AJAX.

#### To accelerate the speed:
I change to use new method of Bing API that can translate all tags of a certain iamge by put them in a String array, instead of sending a request for each time. But it is not fast enough since it still needs 50 requests. So I improve showImages.jsp to not display images's tags until the user chooses certain image, then it will send a request to obtain details.

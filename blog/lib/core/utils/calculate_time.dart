int calculateTime(String content){
	
	final wordCount = content.split(RegExp(r'\s+')).length;
	final timeToRead = wordCount / 225;
	return timeToRead.ceil();
}

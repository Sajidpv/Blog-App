int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
//reading time = wordscount/speed
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}

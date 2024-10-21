import 'dart:io';

class BlogEvent {}

class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final List<String> topic;
  final File image;

  BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topic,
    required this.image,
  });
}

class BlogLoadAll extends BlogEvent {}

class BlogLoadOwn extends BlogEvent {
  final String posterId;
  BlogLoadOwn({required this.posterId});
}

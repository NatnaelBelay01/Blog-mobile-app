class Blog {
  final String id;
  final String posterId;
  final String content;
  final String imageUrl;
  final String title;
  final List<String> topic;
  final DateTime updatedAt;
	final String? posterName;

  Blog({
    required this.id,
    required this.posterId,
    required this.content,
    required this.imageUrl,
    required this.title,
    required this.topic,
    required this.updatedAt,
		this.posterName,
  });
}

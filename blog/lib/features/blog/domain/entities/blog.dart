class Blog {
  final String id;
  final String posterId;
  final String content;
  final String imageUrl;
  final String title;
  final List<String> topics;
  final DateTime updatedAt;

  Blog({
    required this.id,
    required this.posterId,
    required this.content,
    required this.imageUrl,
    required this.title,
    required this.topics,
    required this.updatedAt,
  });
}

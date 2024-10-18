import 'package:blog/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.content,
    required super.imageUrl,
    required super.title,
    required super.topic,
    required super.updatedAt,
		super.posterName,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "poster_id": posterId,
      "content": content,
      "image_url": imageUrl,
      "updated_at": updatedAt.toIso8601String(),
      "topic": topic,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> blogModel) {
    return BlogModel(
      id: blogModel["id"] as String,
      posterId: blogModel["poster_id"] as String,
      updatedAt: blogModel["updated_at"] == null
          ? DateTime.now()
          : DateTime.parse(blogModel["updated_at"]),
      title: blogModel["title"] as String,
      imageUrl: blogModel["image_url"] as String,
      topic: List<String>.from(blogModel["topic"] ?? []),
      content: blogModel["content"] as String,
    );
  }

  BlogModel copyWith({
    String? id,
    List<String>? topic,
    String? imageUrl,
    String? posterId,
    String? title,
    DateTime? updatedAt,
    String? content,
		String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      topic: topic ?? this.topic,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
			posterName: posterName ?? this.posterName,
    );
  }
}

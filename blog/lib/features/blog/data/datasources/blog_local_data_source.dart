import 'package:blog/features/blog/data/model/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceimpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceimpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    // TODO: implement loadBlogs
    throw UnimplementedError();
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i]);
      }
    });
  }
}

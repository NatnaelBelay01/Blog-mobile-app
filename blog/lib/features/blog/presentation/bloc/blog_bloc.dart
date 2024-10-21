import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blog/features/blog/domain/usecase/get_own_blogs.dart';
import 'package:blog/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:blog/features/blog/presentation/bloc/blog_event.dart';
import 'package:blog/features/blog/presentation/bloc/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final GetOwnBlogs _getOwnBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
    required GetOwnBlogs getOwnBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        _getOwnBlogs = getOwnBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUpload>((event, emit) async {
      final result = await _uploadBlog(
        BlogParams(
          content: event.content,
          title: event.title,
          posterId: event.posterId,
          image: event.image,
          topic: event.topic,
        ),
      );

      result.fold(
        (failure) => emit(BlogFailure(failure.message)),
        (blog) => emit(BlogSuccess()),
      );
    });

    on<BlogLoadAll>((event, emit) async {
      final blogList = await _getAllBlogs(NoParams());
      blogList.fold(
        (failure) => emit(BlogFailure(failure.message)),
        (blogs) => emit(BlogLoadSuccess(blogList: blogs)),
      );
    });
    on<BlogLoadOwn>((event, emit) async {
      final blogList = await _getOwnBlogs(OwnParams(posterId: event.posterId));
      blogList.fold(
        (failure) => emit(BlogFailure(failure.message)),
        (blogs) => emit(BlogLoadSuccess(blogList: blogs)),
      );
    });
  }
}

import 'package:blog/features/blog/domain/usecase/upload_blog_usecase.dart';
import 'package:blog/features/blog/presentation/bloc/blog_event.dart';
import 'package:blog/features/blog/presentation/bloc/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc({required this.uploadBlog}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUpload>((event, emit) async {
      final result = await uploadBlog(BlogParams(
        content: event.content,
        title: event.title,
        posterId: event.posterId,
        image: event.image,
        topic: event.topic,
      ));

      result.fold(
        (failure) => emit(BlogFailure()),
        (blog) => emit(BlogSuccess()),
      );
    });
  }
}

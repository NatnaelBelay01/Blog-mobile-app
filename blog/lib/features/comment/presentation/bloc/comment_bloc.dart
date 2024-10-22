import 'package:blog/features/comment/domain/usecase/add_comment_usecase.dart';
import 'package:blog/features/comment/domain/usecase/load_blog_comments_usecase.dart';
import 'package:blog/features/comment/presentation/bloc/comment_event.dart';
import 'package:blog/features/comment/presentation/bloc/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddComment _addComment;
  final LoadBlogComments _loadComments;

  CommentBloc({
    required AddComment addComments,
    required LoadBlogComments loadComments,
  })  : _addComment = addComments,
        _loadComments = loadComments,
        super(CommentInitial()) {
    on<CommentEvent>((event, emit) => emit(CommentLoading()));
    on<FetchComment>((event, emit) async {
      final res = await _loadComments(CommentParams(blogId: event.blogId));
      res.fold(
        (failure) => emit(
          CommentLoadingFailure(message: failure.message),
        ),
        (comments) => emit(
          CommentLoaded(comments: comments),
        ),
      );
    });
    on<AddCommentEvent>((event, emit) async {
      final res = await _addComment(
        AddCommentParam(
          content: event.content,
          blogId: event.blogId,
          userId: event.userId,
        ),
      );
      res.fold(
        (failure) => emit(
          CommentAddingFailure(
            message: failure.message,
          ),
        ),
        (comment) => emit(
          CommentAddingSuccess(),
        ),
      );
    });
  }
}

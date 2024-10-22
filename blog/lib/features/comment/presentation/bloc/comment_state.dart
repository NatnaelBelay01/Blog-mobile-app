import 'package:blog/features/comment/domain/entity/comment.dart';

class CommentState {}

class CommentInitial extends CommentState{}

class CommentLoading extends CommentState{}

class CommentLoadingFailure extends CommentState{
	final String message;
	CommentLoadingFailure({required this.message});
}

class CommentLoaded extends CommentState{
	final List<Comment> comments;
	CommentLoaded({required this.comments});
}

class CommentAddingFailure extends CommentState{
	final String message;
	CommentAddingFailure({required this.message});
}

class CommentAddingSuccess extends CommentState{
}

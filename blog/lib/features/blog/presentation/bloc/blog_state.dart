
import 'package:blog/features/blog/domain/entities/blog.dart';

class BlogState{}

class BlogInitial extends BlogState{}



class BlogLoading extends BlogState{}



class BlogSuccess extends BlogState{
}




class BlogFailure extends BlogState{
	final String message;
	BlogFailure([this.message = 'Something went wrong']);
}


class BlogLoadSuccess extends BlogState{
	final List<Blog> blogList;

	BlogLoadSuccess({required this.blogList});
}

class BlogOwnLoadSuccess extends BlogState{
	final List<Blog> blogList;

	BlogOwnLoadSuccess({required this.blogList});
}

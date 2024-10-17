
class BlogState{}

class BlogInitial extends BlogState{}



class BlogLoading extends BlogState{}



class BlogSuccess extends BlogState{
}




class BlogFailure extends BlogState{
	final String message;
	BlogFailure([this.message = 'Something went wrong']);
}

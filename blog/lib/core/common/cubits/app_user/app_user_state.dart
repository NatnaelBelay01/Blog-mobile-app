import 'package:blog/core/entity/user.dart';

class AppUserState{}


class AppUserInitial extends AppUserState{}



class AppUserLoggedIn extends AppUserState{
	final User user;

	AppUserLoggedIn(this.user);
}

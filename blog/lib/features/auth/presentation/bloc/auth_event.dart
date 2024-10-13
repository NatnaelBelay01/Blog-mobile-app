class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignUp({
    required this.email,
    required this.name,
    required this.password,
  });
}

class LogIn extends AuthEvent {
  final String email;
  final String password;

  LogIn({
    required this.email,
    required this.password,
  });
}

class AuthIsUserLoggedIn extends AuthEvent{}

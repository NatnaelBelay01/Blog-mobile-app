import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domian/usecases/current_user.dart';
import 'package:blog/features/auth/domian/usecases/user_login_usecase.dart';
import 'package:blog/features/auth/domian/usecases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentuser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogIn,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogIn,
        _currentuser = currentUser,
        super(AuthInitial()) {
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final result = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<LogIn>((event, emit) async {
      emit(AuthLoading());
      final result = await _userLogin(
        UserLoginParams(
          email: event.email,
          password: event.password,
        ),
      );
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _currentuser(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        emit(AuthSuccess(user));
      },
    );
  }
}

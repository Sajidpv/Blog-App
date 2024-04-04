import 'package:blog_app/cores/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/cores/usecase/usercase.dart';
import 'package:blog_app/cores/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usercases/current_user.dart';
import 'package:blog_app/features/auth/domain/usercases/user_login.dart';
import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required CurrentUser currentUser,
      required AppUserCubit appUserCubit,
      required UserSignUp userSignUp,
      required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _appUserCubit = appUserCubit,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLogged);
  }

  void _isUserLogged(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));

    response.fold((l) {
      print(l.message);
      emit(AuthFailure(l.message));
    }, (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.email,
      ),
    );

    res.fold((l) {
      print(l.message);
      emit(AuthFailure(l.message));
    }, (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}

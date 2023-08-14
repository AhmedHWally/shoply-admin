part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class LoginSuccess extends LoginState {}

class ResetPasswordStarted extends LoginState {}

class ResetPasswordFailed extends LoginState {
  final String errMessage;
  ResetPasswordFailed({required this.errMessage});
}

class ResetPasswordSuccessed extends LoginState {}

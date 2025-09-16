import '../../models/sign_up_response.dart';
import '../../models/signn_in_response.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final SignInResponse response;

  SignInSuccess(this.response);
}

class SignUpSuccess extends AuthState {
  final SignUpResponse response;
  SignUpSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
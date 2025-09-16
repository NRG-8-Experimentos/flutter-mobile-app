import '../../models/sign_up_request.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent({required this.username, required this.password});
}

class SignUpEvent extends AuthEvent {
  final SignUpRequest request;

  SignUpEvent({required this.request});
}

class ResetAuthStateEvent extends AuthEvent {}
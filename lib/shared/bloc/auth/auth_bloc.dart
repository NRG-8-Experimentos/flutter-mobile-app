import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../client/api_client.dart';
import '../../models/sign_in_request.dart';
import '../../models/sign_up_response.dart';
import '../../models/signn_in_response.dart';
import '../../services/auth_service.dart';
import '../../services/member_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final MemberService memberService;

  AuthBloc({required this.authService, required this.memberService}) : super(AuthInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<ResetAuthStateEvent>(_onResetAuthStateEvent);
  }

  void _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authService.signIn(
        SignInRequest(
          username: event.username,
          password: event.password,
        ),
      );

      if (response.statusCode == 200) {
        final signInResponse = SignInResponse.fromJson(
          json.decode(response.body),
        );
        ApiClient.updateToken(signInResponse.token);
        // Fetch member details
        final memberResponse = await memberService.getMemberDetails();
        if (memberResponse.statusCode == 200) {
          emit(SignInSuccess(signInResponse)); // O puedes emitir un estado con el member
        } else if (memberResponse.statusCode == 404) {
          emit(AuthFailure('No se encontró información del miembro'));
        } else {
          emit(AuthFailure('Error al obtener detalles del miembro: \\nCódigo: \\${memberResponse.statusCode}'));
        }
      } else {
        emit(AuthFailure('Login failed: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AuthFailure('Error: $e'));
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final response = await authService.signUp(event.request);

      if (response.statusCode == 201) {
        final signUpResponse = SignUpResponse.fromJson(json.decode(response.body));
        emit(SignUpSuccess(signUpResponse));
      } else {
        final error = json.decode(response.body)['message'] ?? 'Error en el registro';
        emit(AuthFailure(error));
      }
    } catch (e) {
      emit(AuthFailure('Error de conexión: $e'));
    }
  }

  void _onResetAuthStateEvent(
      ResetAuthStateEvent event,
      Emitter<AuthState> emit,
      ) {
    emit(AuthInitial());
  }
}
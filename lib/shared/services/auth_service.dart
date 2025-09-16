import 'package:http/http.dart' as http;

import '../client/api_client.dart';
import '../models/sign_in_request.dart';
import '../models/sign_up_request.dart';

class AuthService {
  Future<http.Response> signIn(SignInRequest request) async {
    return await ApiClient.post(
      'authentication/sign-in',
      body: request.toJson(),
    );
  }

  Future<http.Response> signUp(SignUpRequest request) async {
    return await ApiClient.post(
      'authentication/sign-up',
      body: request.toJson(),
    );
  }
}
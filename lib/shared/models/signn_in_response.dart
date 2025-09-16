class SignInResponse {
  final int id;
  final String username;
  final String token;

  SignInResponse({
    required this.id,
    required this.username,
    required this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      id: json['id'],
      username: json['username'],
      token: json['token'],
    );
  }
}
class SignUpResponse {
  final int statusCode;
  final String message;

  SignUpResponse({
    required this.statusCode,
    required this.message,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      statusCode: json['statusCode'] ?? 201, // Por defecto 201 si no viene
      message: json['message'] ?? 'Usuario creado exitosamente',
    );
  }
}
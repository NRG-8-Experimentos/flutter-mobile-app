class SignUpRequest {
  final String username;
  final String name;
  final String surname;
  final String imgUrl;
  final String email;
  final String password;
  final List<String> roles;

  SignUpRequest({
    required this.username,
    required this.name,
    required this.surname,
    required this.imgUrl,
    required this.email,
    required this.password,
    this.roles = const ["ROLE_MEMBER"], // Valor por defecto
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'name': name,
    'surname': surname,
    'imgUrl': imgUrl,
    'email': email,
    'password': password,
    'roles': roles,
  };
}
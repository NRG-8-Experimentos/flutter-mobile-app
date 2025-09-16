class Member {
  final int id;
  final String username;
  final String name;
  final String surname;
  final String imgUrl;

  Member({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.imgUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      surname: json['surname'],
      imgUrl: json['imgUrl'] ?? ''
    );
  }
}
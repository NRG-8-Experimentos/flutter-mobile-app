import '../../shared/models/member.dart';

class Group {
  final int id;
  final String name;
  final String imgUrl;
  final String description;
  final String code;
  final int memberCount;
  final List<Member> members;

  Group({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.description,
    required this.code,
    required this.memberCount,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List<dynamic>? ?? [];
    return Group(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      members: membersList.map((member) => Member.fromJson(member)).toList(),
    );
  }

  // Opcional: método para convertir a Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imgUrl': imgUrl,
    'description': description,
    'code': code,
    'memberCount': memberCount,
  };
}
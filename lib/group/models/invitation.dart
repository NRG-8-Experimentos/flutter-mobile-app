import 'group.dart';

class Invitation {
  final int id;
  final Group group;

  Invitation({
    required this.id,
    required this.group,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'],
      group: Group.fromJson(json['group']),
    );
  }
}
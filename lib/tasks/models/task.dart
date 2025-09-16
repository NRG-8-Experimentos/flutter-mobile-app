class Task {
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final String createdAt;
  final String updatedAt;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status']
    );
  }
}
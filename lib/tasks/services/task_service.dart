import 'dart:convert';

import '../../shared/client/api_client.dart';
import '../models/task.dart';

class TaskService {
  Future<List<Task>> getMemberTasks() async {
    final response = await ApiClient.get('member/tasks');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Task.fromJson(json)).toList();
    }
    throw Exception('Failed to load member tasks');
  }

  Future<Task> getTaskById(int taskId) async {
    final response = await ApiClient.get('tasks/$taskId');
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load task');
  }

  Future<void> updateTaskStatus(int taskId, String status) async {
    final response = await ApiClient.put(
      'tasks/$taskId/status/$status',
      body: null,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task status');
    }
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../tasks/models/task.dart';
import '../client/api_client.dart';

class MemberService {
  Future<http.Response> getMemberDetails() async {
    return await ApiClient.get('member/details');
  }

  Future<http.Response> getMemberGroup() async {
    return await ApiClient.get('member/group');
  }

  Future<bool> leaveGroup() async {
    final response = await ApiClient.delete('member/group/leave');
    return response.statusCode == 204;
  }

  Future<Task?> getNextTask() async {
    final response = await ApiClient.get('member/tasks/next');
    //print('[getNextTask] statusCode: ${response.statusCode}');
    //print('[getNextTask] body: ${response.body}');
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    }
    throw Exception('Failed to load next task');
  }
}
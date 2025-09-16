import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../shared/client/api_client.dart';
import '../models/group.dart';

class GroupService {
  Future<http.Response> searchGroupByCode(String code) async {
    return await ApiClient.get('groups/search?code=$code');
  }
  Future<Group> getMemberGroup() async {
    final response = await ApiClient.get('member/group');
    if (response.statusCode == 200) {
      return Group.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load member group');
  }
}
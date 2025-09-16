import 'package:http/http.dart' as http;
import '../../shared/client/api_client.dart';

class InvitationService {
  Future<http.Response> getMemberInvitation() async {
    return await ApiClient.get('invitations/member');
  }

  Future<http.Response> sendGroupInvitation(int groupId) async {
    return await ApiClient.post('invitations/groups/$groupId');
  }

  Future<http.Response> deleteMemberInvitation() async {
    return await ApiClient.delete('invitations/member');
  }
}
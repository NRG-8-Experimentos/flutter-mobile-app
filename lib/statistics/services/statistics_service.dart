import 'dart:convert';
import '../models/statistics.dart';
import '../../shared/client/api_client.dart';

class StatisticsService {
  final String baseUrl;

  // No es necesario definir baseUrl, ApiClient ya lo maneja internamente
  StatisticsService({this.baseUrl = ''});

  bool _isHtml(String body) {
    return body.trimLeft().startsWith('<!DOCTYPE html') ||
           body.trimLeft().startsWith('<html');
  }

  Future<MemberStatistics> fetchMemberStatistics(String memberId) async {
    final overviewRes = await ApiClient.get('metrics/member/$memberId/tasks/overview');
    final distributionRes = await ApiClient.get('metrics/member/$memberId/tasks/distribution');
    final rescheduledRes = await ApiClient.get('metrics/member/$memberId/tasks/rescheduled');
    final avgCompletionRes = await ApiClient.get('metrics/member/$memberId/tasks/avg-completion-time');

    print('Overview status: ${overviewRes.statusCode}, body: ${overviewRes.body}');
    print('Distribution status: ${distributionRes.statusCode}, body: ${distributionRes.body}');
    print('Rescheduled status: ${rescheduledRes.statusCode}, body: ${rescheduledRes.body}');
    print('AvgCompletion status: ${avgCompletionRes.statusCode}, body: ${avgCompletionRes.body}');

    if (_isHtml(overviewRes.body) ||
        _isHtml(distributionRes.body) ||
        _isHtml(rescheduledRes.body) ||
        _isHtml(avgCompletionRes.body)) {
      throw Exception('La respuesta del servidor no es JSON. Verifica la URL base de la API.');
    }

    if (overviewRes.statusCode == 200 &&
        distributionRes.statusCode == 200 &&
        rescheduledRes.statusCode == 200 &&
        avgCompletionRes.statusCode == 200) {
      dynamic decodeBody(String body) {
        final decoded = json.decode(body);
        if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
          return decoded['data'];
        }
        return decoded;
      }

      final overview = TaskOverview.fromJson(decodeBody(overviewRes.body));
      final distribution = TaskDistribution.fromJson(decodeBody(distributionRes.body));
      final rescheduled = RescheduledTasks.fromJson(decodeBody(rescheduledRes.body));
      final avgCompletion = AvgCompletionTime.fromJson(decodeBody(avgCompletionRes.body));

      return MemberStatistics(
        overview: overview,
        distribution: distribution,
        rescheduledTasks: rescheduled,
        avgCompletionTime: avgCompletion,
      );
    } else {
      throw Exception(
        'Failed to load statistics\n'
        'Overview: ${overviewRes.statusCode}\n'
        'Distribution: ${distributionRes.statusCode}\n'
        'Rescheduled: ${rescheduledRes.statusCode}\n'
        'AvgCompletion: ${avgCompletionRes.statusCode}'
      );
    }
  }
}


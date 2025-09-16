abstract class StatisticsEvent {}

class LoadMemberStatistics extends StatisticsEvent {
  final String memberId;

  LoadMemberStatistics(this.memberId);
}

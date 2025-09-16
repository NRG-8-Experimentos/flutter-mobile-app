import 'package:flutter_bloc/flutter_bloc.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';
import '../services/statistics_service.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsService statisticsService;

  StatisticsBloc(this.statisticsService) : super(StatisticsInitial()) {
    on<LoadMemberStatistics>((event, emit) async {
      emit(StatisticsLoading());
      try {
        final stats = await statisticsService.fetchMemberStatistics(event.memberId);
        emit(StatisticsLoaded(stats));
      } catch (e) {
        emit(StatisticsError('Failed to load statistics'));
      }
    });
  }
}

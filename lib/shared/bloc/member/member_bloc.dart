import 'dart:convert';
import 'package:bloc/bloc.dart';
import '../../../group/models/group.dart';
import '../../models/member.dart';
import '../../services/member_service.dart';
import 'member_event.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberService memberService;

  MemberBloc({required this.memberService}) : super(MemberInitial()) {
    on<FetchMemberDetailsEvent>(_onFetchMemberDetails);
    on<LoadMemberGroupEvent>(_onLoadMemberGroup);
    on<LeaveGroupEvent>(_onLeaveGroup);
    on<LoadNextTaskEvent>(_onLoadNextTask);
  }

  Future<void> _onFetchMemberDetails(
      FetchMemberDetailsEvent event,
      Emitter<MemberState> emit,
      ) async {
    emit(MemberLoading());
    try {
      final response = await memberService.getMemberDetails();

      if (response.statusCode == 200) {
        final member = Member.fromJson(json.decode(response.body));
        emit(MemberLoaded(member));
      } else {
        emit(MemberError('Failed to load member details'));
      }
    } catch (e) {
      emit(MemberError('Error: $e'));
    }
  }

  Future<void> _onLoadMemberGroup(
      LoadMemberGroupEvent event,
      Emitter<MemberState> emit,
      ) async {
    emit(MemberLoading());
    try {
      final response = await memberService.getMemberGroup();

      if (response.statusCode == 200) {
        final group = Group.fromJson(json.decode(response.body));
        emit(MemberGroupLoaded(group));
      } else if (response.statusCode == 404) {
        emit(MemberNoGroup()); // Nuevo estado para cuando el miembro no tiene grupo
      } else {
        emit(MemberError('Failed to load member group'));
      }
    } catch (e) {
      emit(MemberError('Error loading member group: $e'));
    }
  }

  Future<void> _onLeaveGroup(
      LeaveGroupEvent event,
      Emitter<MemberState> emit,
      ) async {
    emit(MemberLoading());
    try {
      final success = await memberService.leaveGroup();
      if (success) {
        emit(GroupLeftSuccessfully());
      } else {
        emit(MemberError('Failed to leave group'));
      }
    } catch (e) {
      emit(MemberError('Error leaving group: $e'));
    }
  }

  Future<void> _onLoadNextTask(
      LoadNextTaskEvent event,
      Emitter<MemberState> emit,
      ) async {
    emit(NextTaskLoading());
    try {
      final task = await memberService.getNextTask();
      if (task != null) {
        emit(NextTaskLoaded(task));
      } else {
        emit(NoNextTaskAvailable());
      }
    } catch (e) {
      emit(NextTaskError('Error loading next task: $e'));
    }
  }
}
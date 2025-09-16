import 'dart:convert';
import 'package:bloc/bloc.dart';
import '../../models/group.dart';
import '../../services/group_service.dart';
import 'group_event.dart';
import 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupService groupService;

  GroupBloc({required this.groupService}) : super(GroupInitial()) {
    on<SearchGroupByCodeEvent>(_onSearchGroupByCode);
    on<LoadMemberGroupEvent>(_onLoadMemberGroup);
  }

  Future<void> _onSearchGroupByCode(
      SearchGroupByCodeEvent event,
      Emitter<GroupState> emit,
      ) async {
    emit(GroupLoading());
    try {
      final response = await groupService.searchGroupByCode(event.code);

      if (response.statusCode == 200) {
        final group = Group.fromJson(json.decode(response.body));
        emit(GroupFound(group));
      } else if (response.statusCode == 404) {
        emit(GroupNotFound('No se encontró el grupo con ese código'));
      } else {
        emit(GroupError('Error al buscar el grupo: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GroupError('Error de conexión: $e'));
    }
  }

  Future<void> _onLoadMemberGroup(
      LoadMemberGroupEvent event,
      Emitter<GroupState> emit,
      ) async {
    emit(GroupLoading());
    try {
      final group = await groupService.getMemberGroup();
      emit(MemberGroupLoaded(group));
    } catch (e) {
      emit(GroupError('Error loading member group: $e'));
    }
  }
}
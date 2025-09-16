import 'dart:convert';

import 'package:bloc/bloc.dart';

import '../../models/invitation.dart';
import '../../services/invitation_service.dart';
import 'invitation_event.dart';
import 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final InvitationService invitationService;

  InvitationBloc({required this.invitationService}) : super(InvitationInitial()) {
    on<SendGroupInvitationEvent>(_onSendGroupInvitation);
    on<LoadMemberInvitationEvent>(_onLoadMemberInvitation);
    on<CancelMemberInvitationEvent>(_onCancelMemberInvitation);
  }

  Future<void> _onSendGroupInvitation(
      SendGroupInvitationEvent event,
      Emitter<InvitationState> emit,
      ) async {
    emit(InvitationLoading());
    try {
      final response = await invitationService.sendGroupInvitation(event.groupId);

      if (response.statusCode == 200) {
        emit(GroupInvitationSent(event.groupId));
      } else {
        final error = json.decode(response.body)['message'] ?? 'Error al enviar invitación';
        emit(InvitationError(error));
      }
    } catch (e) {
      emit(InvitationError('Error de conexión: $e'));
    }
  }

  Future<void> _onLoadMemberInvitation(
      LoadMemberInvitationEvent event,
      Emitter<InvitationState> emit,
      ) async {
    emit(InvitationLoading());
    try {
      final response = await invitationService.getMemberInvitation();

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData != null) {
          final invitation = Invitation.fromJson(jsonData);
          emit(MemberInvitationLoaded(invitation));
        } else {
          emit(NoMemberInvitation());
        }
      } else if (response.statusCode == 404) {
        emit(NoMemberInvitation());
      } else {
        emit(InvitationError('Error al cargar invitación'));
      }
    } catch (e) {
      emit(InvitationError('Error de conexión: $e'));
    }
  }

  Future<void> _onCancelMemberInvitation(
      CancelMemberInvitationEvent event,
      Emitter<InvitationState> emit,
      ) async {
    emit(InvitationLoading());
    try {
      final response = await invitationService.deleteMemberInvitation();
      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(MemberInvitationCancelled());
        emit(NoMemberInvitation());
      } else {
        final error = json.decode(response.body)['message'] ?? 'Error al cancelar invitación';
        emit(InvitationError(error));
      }
    } catch (e) {
      emit(InvitationError('Error de conexión: $e'));
    }
  }
}
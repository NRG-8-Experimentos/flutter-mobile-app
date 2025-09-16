import '../../models/invitation.dart';

abstract class InvitationState {}

class InvitationInitial extends InvitationState {}

class InvitationLoading extends InvitationState {}

// Para cuando se envía una invitación
class GroupInvitationSent extends InvitationState {
  final int groupId;

  GroupInvitationSent(this.groupId);
}

// Para cuando se carga la invitación del miembro
class MemberInvitationLoaded extends InvitationState {
  final Invitation invitation;

  MemberInvitationLoaded(this.invitation);
}

// Cuando no hay invitación para el miembro
class NoMemberInvitation extends InvitationState {}

// Estado para cuando se cancela la invitación
class MemberInvitationCancelled extends InvitationState {}

class InvitationError extends InvitationState {
  final String message;

  InvitationError(this.message);
}
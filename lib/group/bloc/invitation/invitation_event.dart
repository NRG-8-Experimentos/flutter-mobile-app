abstract class InvitationEvent {}

class LoadMemberInvitationEvent extends InvitationEvent {}

class SendGroupInvitationEvent extends InvitationEvent {
  final int groupId;

  SendGroupInvitationEvent(this.groupId);
}

class CancelMemberInvitationEvent extends InvitationEvent {}

abstract class MemberEvent {}

class FetchMemberDetailsEvent extends MemberEvent {}

class LoadMemberGroupEvent extends MemberEvent {}

class LeaveGroupEvent extends MemberEvent {}

class LoadNextTaskEvent extends MemberEvent {}
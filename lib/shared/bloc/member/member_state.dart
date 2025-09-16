import '../../../group/models/group.dart';
import '../../../tasks/models/task.dart';
import '../../models/member.dart';

abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final Member member;

  MemberLoaded(this.member);
}

class MemberError extends MemberState {
  final String message;

  MemberError(this.message);
}

class MemberGroupLoaded extends MemberState {
  final Group group;

  MemberGroupLoaded(this.group);
}

class MemberNoGroup extends MemberState {}

class GroupLeftSuccessfully extends MemberState {}

class NextTaskLoaded extends MemberState {
  final Task task;

  NextTaskLoaded(this.task);
}

class NoNextTaskAvailable extends MemberState {}

class NextTaskError extends MemberState {
  final String message;
  NextTaskError(this.message);
}

class NextTaskLoading extends MemberState {}
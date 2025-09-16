import '../../models/group.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupFound extends GroupState {
  final Group group;

  GroupFound(this.group);
}

class GroupNotFound extends GroupState {
  final String message;

  GroupNotFound(this.message);
}

class GroupError extends GroupState {
  final String error;

  GroupError(this.error);
}

class MemberGroupLoaded extends GroupState {
  final Group group;

  MemberGroupLoaded(this.group);
}
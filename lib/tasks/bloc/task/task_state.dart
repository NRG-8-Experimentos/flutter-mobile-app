import '../../models/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskStatusUpdated extends TaskState {}

class MemberTasksLoaded extends TaskState {
  final List<Task> tasks;

  MemberTasksLoaded(this.tasks);
}

class TaskDetailLoaded extends TaskState {
  final Task task;

  TaskDetailLoaded(this.task);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
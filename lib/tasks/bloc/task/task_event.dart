abstract class TaskEvent {}

class LoadMemberTasksEvent extends TaskEvent {}

class LoadTaskByIdEvent extends TaskEvent {
  final int taskId;

  LoadTaskByIdEvent(this.taskId);
}

class UpdateTaskStatusEvent extends TaskEvent {
  final int taskId;
  final String status;

  UpdateTaskStatusEvent({
    required this.taskId,
    required this.status,
  });
}
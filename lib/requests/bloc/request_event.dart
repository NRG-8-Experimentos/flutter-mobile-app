abstract class RequestEvent {}

class LoadMemberRequestsEvent extends RequestEvent {}

class LoadRequestByIdEvent extends RequestEvent {
  final int taskId;
  final int requestId;
  LoadRequestByIdEvent({ required this.taskId, required this.requestId});
}

class CreateRequestEvent extends RequestEvent {
  final int taskId;
  final String description;
  final String requestType;

  CreateRequestEvent({
    required this.description,
    required this.requestType,
    required this.taskId,
  });
}
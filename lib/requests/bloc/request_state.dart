import '../models/request.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class MemberRequestsLoaded extends RequestState {
  final List<Request> requests;

  MemberRequestsLoaded(this.requests);
}

class RequestDetailLoaded extends RequestState {
  final Request request;

  RequestDetailLoaded(this.request);
}

class RequestError extends RequestState {
  final String message;

  RequestError(this.message);
}
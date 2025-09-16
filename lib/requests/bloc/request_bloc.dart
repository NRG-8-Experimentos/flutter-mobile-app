import 'package:bloc/bloc.dart';
import 'package:synhub_flutter/requests/bloc/request_event.dart';
import 'package:synhub_flutter/requests/bloc/request_state.dart';


import '../services/request_service.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestService requestService;

  RequestBloc({required this.requestService}): super (RequestInitial()) {
    on<LoadMemberRequestsEvent>(_onLoadMemberRequests);
    on<LoadRequestByIdEvent>(_onLoadRequestById);
    on<CreateRequestEvent>(_onCreateRequest);
  }

  Future<void> _onLoadMemberRequests(
      LoadMemberRequestsEvent event,
      Emitter<RequestState> emit,
      ) async {
    emit(RequestLoading());
    try {
      final requests = await requestService.getMemberRequests();
      emit(MemberRequestsLoaded(requests));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> _onLoadRequestById(
      LoadRequestByIdEvent event,
      Emitter<RequestState> emit,
      ) async {
    emit(RequestLoading());
    try {
      final request = await requestService.getRequestById(event.taskId, event.requestId);
      emit(RequestDetailLoaded(request));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

  Future<void> _onCreateRequest(
      CreateRequestEvent event,
      Emitter<RequestState> emit,
      ) async {
    emit(RequestLoading());
    try {
      final request = await requestService.createRequest(
        event.taskId,
        event.description,
        event.requestType,
      );
      emit(RequestDetailLoaded(request));
    } catch (e) {
      emit(RequestError(e.toString()));
    }
  }

}
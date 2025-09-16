import 'package:bloc/bloc.dart';
import 'package:synhub_flutter/tasks/bloc/task/task_event.dart';
import 'package:synhub_flutter/tasks/bloc/task/task_state.dart';

import '../../services/task_service.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc({required this.taskService}) : super(TaskInitial()) {
    on<LoadMemberTasksEvent>(_onLoadMemberTasks);
    on<LoadTaskByIdEvent>(_onLoadTaskById);
    on<UpdateTaskStatusEvent>(_onUpdateTaskStatus);
  }

  Future<void> _onLoadMemberTasks(
      LoadMemberTasksEvent event,
      Emitter<TaskState> emit,
      ) async {
    emit(TaskLoading());
    try {
      final tasks = await taskService.getMemberTasks();
      emit(MemberTasksLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onLoadTaskById(
      LoadTaskByIdEvent event,
      Emitter<TaskState> emit,
      ) async {
    emit(TaskLoading());
    try {
      final task = await taskService.getTaskById(event.taskId);
      emit(TaskDetailLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onUpdateTaskStatus(
      UpdateTaskStatusEvent event,
      Emitter<TaskState> emit,
      ) async {
    emit(TaskLoading());
    try {
      await taskService.updateTaskStatus(event.taskId, event.status);
      emit(TaskStatusUpdated());
      final tasks = await taskService.getMemberTasks();
      emit(MemberTasksLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synhub_flutter/requests/bloc/request_bloc.dart';
import 'package:synhub_flutter/requests/services/request_service.dart';
import 'package:synhub_flutter/shared/bloc/auth/auth_bloc.dart';
import 'package:synhub_flutter/shared/bloc/member/member_bloc.dart';
import 'package:synhub_flutter/shared/services/auth_service.dart';
import 'package:synhub_flutter/shared/services/member_service.dart';
import 'package:synhub_flutter/shared/views/Login.dart';
import 'package:synhub_flutter/tasks/bloc/task/task_bloc.dart';
import 'package:synhub_flutter/tasks/services/task_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authService: AuthService(),
            memberService: MemberService(),
          ),
        ),
        BlocProvider(
          create: (_) => MemberBloc(memberService: MemberService()),
        ),
        BlocProvider(
          create: (_) => TaskBloc(taskService: TaskService()),
        ),
        BlocProvider(
          create: (_) => RequestBloc(requestService: RequestService()),
        )
      ],
      child: MaterialApp(
        title: 'SynHub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Login(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synhub_flutter/group/bloc/group/group_event.dart' hide LoadMemberGroupEvent;

import '../../shared/bloc/member/member_bloc.dart';
import '../../shared/bloc/member/member_event.dart';
import '../../shared/bloc/member/member_state.dart' hide MemberGroupLoaded;
import '../../shared/client/api_client.dart';
import '../../shared/services/member_service.dart';
import '../../shared/views/Login.dart';
import '../bloc/group/group_bloc.dart';
import '../bloc/group/group_state.dart';
import '../models/group.dart';
import '../services/group_service.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(
          create: (context) => GroupBloc(groupService: GroupService())..add(LoadMemberGroupEvent() as GroupEvent),
        ),
        BlocProvider<MemberBloc>(
          create: (context) => MemberBloc(memberService: MemberService()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              String title = 'Group';
              if (state is MemberGroupLoaded) {
                title = state.group.name;
              } else if (state is GroupLoading) {
                title = 'Cargando...';
              } else if (state is GroupError) {
                title = 'Error';
              }
              return AppBar(
                backgroundColor: Colors.white,
                title: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              );
            },
          ),
        ),
        body: BlocListener<MemberBloc, MemberState>(
          listener: (context, state) {
            if (state is GroupLeftSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Has abandonado el grupo exitosamente.')),
              );
              ApiClient.resetToken();
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              });
            } else if (state is MemberError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MemberGroupLoaded) {
                return _buildGroupContent(context, state.group);
              } else if (state is GroupError) {
                return Center(child: Text(state.error));
              }
              return const Center(child: Text('No hay datos'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGroupContent(BuildContext context, Group group) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Card(
              color: Color(0xFF4A90E2),
              elevation: 5,
              child:
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('#${group.code}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                )
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Card(
              color: Color(0xFF1A4E85),
              elevation: 5,
              child:
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(group.description,
                      style:
                      TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      ),
                    textAlign: TextAlign.justify,
                  ),
                )
            ),
          ),
          const SizedBox(height: 12),
          Text('Tus compañeros de equipo:',
              style:
              TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A4E85)
              )
          ),
          const SizedBox(height: 12),
          Card(
            color: Color(0xFFF5F5F5),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                elevation: 5,
                  child: SizedBox(
                  height: 350, // Altura máxima para evitar desbordes
                  child: ListView(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: group.members.map((member) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(member.imgUrl),
                        ),
                        title: Text('${member.name} ${member.surname}'),
                        subtitle: Text(member.username, style: TextStyle(color: Colors.grey[500])),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: OutlinedButton(
              onPressed: () {
                final parentContext = context;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Abandonar grupo?', style: TextStyle(color: Color(0xFF1A4E85), fontWeight: FontWeight.bold)),
                    content: const Text('¿Estás seguro de que deseas abandonar este grupo? Esta acción no se puede deshacer.'),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF1A4E85),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFF44336),
                        ),
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          BlocProvider.of<MemberBloc>(parentContext, listen: false).add(LeaveGroupEvent());
                        },
                        child: const Text('Abandonar', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFF44336),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Abandonar Grupo', style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}
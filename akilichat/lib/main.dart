import 'package:akilichat/bloc/chta_bloc.dart';
import 'package:akilichat/screens/chat_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Assistant',
      home: BlocProvider(
        create: (_) => ChatBloc(),
        child: ChatPage(),
      ),
    );
  }
}
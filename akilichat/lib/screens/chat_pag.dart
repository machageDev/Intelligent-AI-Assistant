import 'package:akilichat/bloc/chat_state.dart';
import 'package:akilichat/bloc/chta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Assistant"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];

                    return MessageBubble(
                      text: message.text,
                      isUser: message.isUser,
                    );
                  },
                );
              },
            ),
          ),

          ChatInput(controller: controller),
        ],
      ),
    );
  }
}
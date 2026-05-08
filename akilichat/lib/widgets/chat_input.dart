import 'package:akilichat/bloc/chat_event.dart';
import 'package:akilichat/bloc/chta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChatInput extends StatelessWidget {
  final TextEditingController controller;

  const ChatInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Ask something...",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            FloatingActionButton(
              mini: true,
              onPressed: () {
                if (controller.text.trim().isEmpty) return;

                context.read<ChatBloc>().add(
                      SendMessageEvent(controller.text),
                    );

                controller.clear();
              },
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
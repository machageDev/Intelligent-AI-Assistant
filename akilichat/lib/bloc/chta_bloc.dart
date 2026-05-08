import 'dart:async';

import 'package:akilichat/bloc/chat_event.dart';
import 'package:akilichat/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message_model.dart';



class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(messages: [])) {
    on<SendMessageEvent>(_sendMessage);
  }

  Future<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final updatedMessages = List<MessageModel>.from(state.messages)
      ..add(MessageModel(
        text: event.message,
        isUser: true,
      ));

    emit(state.copyWith(
      messages: updatedMessages,
      isTyping: true,
    ));

    await Future.delayed(const Duration(seconds: 1));

    updatedMessages.add(
      MessageModel(
        text: "AI Response to: ${event.message}",
        isUser: false,
      ),
    );

    emit(state.copyWith(
      messages: updatedMessages,
      isTyping: false,
    ));
  }
}
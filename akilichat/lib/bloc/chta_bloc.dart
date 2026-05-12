import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akilichat/bloc/chat_event.dart';
import 'package:akilichat/bloc/chat_state.dart';
import '../models/message_model.dart';
// Make sure to import your service and the Google AI package
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  // Initialize the model here (or inject a service)
  final _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'YOUR_FREE_API_KEY',
  );
  
  late final ChatSession _chat;

  ChatBloc() : super(ChatState(messages: [])) {
    // Start a chat session to maintain history automatically
    _chat = _model.startChat();
    
    // Define the handler once
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    // 1. Add User Message and set typing state
    final userMessage = MessageModel(text: event.message, isUser: true);
    final updatedMessages = List<MessageModel>.from(state.messages)..add(userMessage);

    emit(state.copyWith(
      messages: updatedMessages,
      isTyping: true,
    ));

    try {
      // 2. Call the Gemini API
      final response = await _chat.sendMessage(Content.text(event.message));
      final botText = response.text;

      if (botText != null) {
        // 3. Add Bot Response and stop typing
        final finalMessages = List<MessageModel>.from(updatedMessages)
          ..add(MessageModel(text: botText, isUser: false));

        emit(state.copyWith(
          messages: finalMessages,
          isTyping: false,
        ));
      }
    } catch (e) {
      // Handle errors (like no internet or rate limits)
      emit(state.copyWith(isTyping: false));
      // Optionally emit an error state if your ChatState supports it
    }
  }
}
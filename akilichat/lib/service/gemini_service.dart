import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiService() {
    // Initialize with the free Gemini 1.5 Flash model
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'YOUR_FREE_API_KEY_HERE', // Use an env variable for security
    );
    // startChat allows the model to remember previous messages
    _chat = _model.startChat();
  }

  Future<String?> getResponse(String prompt) async {
    final response = await _chat.sendMessage(Content.text(prompt));
    return response.text;
  }
}
// lib/services/screens/chatbot_screen.dart

import 'package:flutter/material.dart';
import 'package:capstoneproject/services/database/database.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:capstoneproject/services/app_services.dart';

// Correctly define the ChatbotScreen StatefulWidget
class ChatbotScreen extends StatefulWidget {
  final List<ScanResult>? scanResults; // Make the list optional for now

  const ChatbotScreen({super.key, this.scanResults});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String?>> _messages = [];
  ChatSession? _chatSession;
  late final String _initialPrompt;
  bool _isApiReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initialPrompt = _generateInitialPrompt();
    _initializeChatbot();
  }

  Future<void> _initializeChatbot() async {
    // Try to load API key from .env file first
    String? apiKey = dotenv.env['GEMINI_API_KEY'];

    // Fallback to the hardcoded key from app_services.dart if .env is not loaded
    if (apiKey == null || apiKey.isEmpty) {
      apiKey = GEMINI_API_KEY;
    }

    // Validate that we have a valid API key
    if (apiKey.isNotEmpty && apiKey.length > 10) {
      try {
        // ✅ Updated model: from gemini-1.5-flash → gemini-2.5-flash
        final model = GenerativeModel(
          model: 'gemini-2.5-flash', // <-- Updated for consistency and stability
          apiKey: apiKey,
        );

        // Initialize chat session with initial prompt as first message
        // The prompt will be included in the first user message instead
        _chatSession = model.startChat();

        _isApiReady = true;
        _errorMessage = null;
      } catch (e) {
        _isApiReady = false;
        _errorMessage = 'Failed to initialize: $e';
        if (mounted) {
          setState(() {
            _messages.add({
              'sender': 'bot',
              'text': 'ERROR: Failed to initialize chatbot. ${e.toString()}',
            });
          });
        }
      }
    } else {
      _isApiReady = false;
      _errorMessage = 'Invalid API key';
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'text':
                'ERROR: API key not found. Please create a .env file with GEMINI_API_KEY=your_key',
          });
        });
      }
    }
  }

  String _generateInitialPrompt() {
    if (widget.scanResults == null || widget.scanResults!.isEmpty) {
      return "You are a cybersecurity assistant. A scan was recently performed and found no threats. The user is safe. Answer their security-related questions concisely.";
    }

    final threatList = widget.scanResults!
        .map(
          (result) =>
              "- ${result.appName} (Package: ${result.packageName}): Threat - ${result.threatName}, Severity - ${result.severityLevel}",
        )
        .join('\n');

    return "You are a cybersecurity assistant named Sentinel AI. A recent device scan found the following threats:\n$threatList\n\nYour goal is to help the user understand these threats, explain the next steps (e.g., uninstalling the app), and answer general cybersecurity questions. **Always reference the scan results if the user asks about them.**";
  }

  Future<void> _sendMessage() async {
    if (!_isApiReady || _chatSession == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _errorMessage ?? 'Chatbot API is not ready. Cannot send message.',
          ),
        ),
      );
      return;
    }

    final userMessage = _textController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': userMessage});
      _textController.clear();
      _messages.add({'sender': 'bot', 'text': '...'}); // Placeholder
    });

    final loadingIndex = _messages.length - 1;

    try {
      // For the first message, include the system prompt
      final messageToSend = _messages.length == 2
          ? "$_initialPrompt\n\nUser Question: $userMessage"
          : userMessage;

      // Send message using chat session (maintains conversation history)
      final response = await _chatSession!.sendMessage(
        Content.text(messageToSend),
      );

      final botReply = response.text;

      if (mounted) {
        setState(() {
          if (botReply != null && botReply.isNotEmpty) {
            _messages[loadingIndex] = {'sender': 'bot', 'text': botReply};
          } else {
            _messages[loadingIndex] = {
              'sender': 'bot',
              'text': 'Sorry, I received an empty response. Please try again.',
            };
          }
        });
      }
    } catch (e) {
      print('Error calling API: $e');
      if (mounted) {
        setState(() {
          String errorMsg = 'Sorry, I couldn\'t process your request. ';
          if (e.toString().contains('API_KEY_INVALID') ||
              e.toString().contains('PERMISSION_DENIED')) {
            errorMsg +=
                'API key issue. Please check your API key configuration.';
          } else if (e.toString().contains('network') ||
              e.toString().contains('SocketException')) {
            errorMsg += 'Network error. Please check your internet connection.';
          } else {
            errorMsg += 'Error: ${e.toString()}';
          }

          _messages[loadingIndex] = {'sender': 'bot', 'text': errorMsg};
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message['sender'] == 'bot';
                final isPlaceholder = message['text'] == '...';

                return ListTile(
                  title: Text(
                    message['text'] ?? '',
                    style: TextStyle(
                      fontStyle:
                          isPlaceholder ? FontStyle.italic : FontStyle.normal,
                      color: isBot ? Colors.black : Colors.blue,
                    ),
                  ),
                  leading: Icon(
                    isBot ? Icons.android : Icons.person,
                    color: isBot ? Colors.green : Colors.blue,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

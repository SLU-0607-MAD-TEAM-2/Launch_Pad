import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/mock_api_service.dart';

class ChatProvider extends ChangeNotifier {
  final MockApiService _apiService;
  final Map<String, List<Message>> _conversations = {};

  ChatProvider(this._apiService);

  List<Message> messagesFor(String userId) =>
      _conversations[userId] ?? [];

  void loadConversations() {
    _conversations.clear();
    for (final profile in _apiService.profiles) {
      final msgs = _apiService.messagesFor(profile.id);
      if (msgs.isNotEmpty) {
        _conversations[profile.id] = List.from(msgs);
      }
    }
    notifyListeners();
  }

  void sendMessage(String receiverId, String content) {
    final msg = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'current_user',
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
      isRead: true,
    );
    _conversations.putIfAbsent(receiverId, () => []);
    _conversations[receiverId]!.add(msg);
    notifyListeners();
  }
}

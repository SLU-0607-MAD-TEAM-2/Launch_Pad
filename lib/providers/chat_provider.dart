import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../data/sample_data.dart';

class ChatProvider extends ChangeNotifier {
  final Map<String, List<Message>> _conversations = {};

  List<Message> messagesFor(String userId) =>
      _conversations[userId] ?? [];

  void loadConversations() {
    _conversations.clear();
    for (final entry in SampleData.conversations.entries) {
      _conversations[entry.key] = List.from(entry.value);
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

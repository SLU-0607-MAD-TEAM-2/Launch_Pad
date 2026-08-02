import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import '../services/firebase_data_service.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseDataService _firebase = FirebaseDataService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription<List<Message>>? _messagesSubscription;
  StreamSubscription<QuerySnapshot>? _conversationsSubscription;
  List<Message> _currentMessages = [];
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = false;

  List<Message> get currentMessages => _currentMessages;
  List<Map<String, dynamic>> get conversations => _conversations;
  bool get isLoading => _isLoading;

  String? get _currentUserId => _auth.currentUser?.uid;

  /// Start listening to conversations in real-time
  void startListeningToConversations() {
    _conversationsSubscription?.cancel();
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    _conversationsSubscription = _db
        .collection('conversations')
        .where('participants', arrayContains: currentUserId)
        .snapshots()
        .listen((snapshot) async {
      final conversations = <Map<String, dynamic>>[];
      
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final participants = List<String>.from(data['participants'] ?? []);
        final otherUserId = participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );
        if (otherUserId.isEmpty) continue;

        // Get other user's profile
        final userDoc = await _db.collection('users').doc(otherUserId).get();
        if (!userDoc.exists) continue;
        final userData = userDoc.data()!;

        // Get last message
        final messagesSnap = await _db
            .collection('conversations')
            .doc(doc.id)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        String lastMessage = '';
        DateTime? lastTime;
        if (messagesSnap.docs.isNotEmpty) {
          final msgData = messagesSnap.docs.first.data();
          lastMessage = msgData['content'] ?? '';
          lastTime = (msgData['timestamp'] as Timestamp?)?.toDate();
        }

        conversations.add({
          'conversationId': doc.id,
          'userId': otherUserId,
          'name': userData['name'] ?? 'Unknown',
          'avatar': userData['avatarUrl'] ?? '',
          'role': userData['role'] ?? '',
          'lastMessage': lastMessage,
          'lastTime': lastTime,
        });
      }

      // Sort by last message time (newest first)
      conversations.sort((a, b) {
        final aTime = a['lastTime'] as DateTime?;
        final bTime = b['lastTime'] as DateTime?;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });

      _conversations = conversations;
      _isLoading = false;
      notifyListeners();
    });
  }

  /// Stop listening to conversations
  void stopListeningToConversations() {
    _conversationsSubscription?.cancel();
    _conversationsSubscription = null;
  }

  /// Load conversations list (one-time fetch as fallback)
  Future<void> loadConversations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _conversations = await _firebase.getConversations();
    } catch (e) {
      _conversations = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  /// Start listening to real-time messages in a conversation
  void startListening(String conversationId) {
    _messagesSubscription?.cancel();
    _messagesSubscription = _firebase.watchMessages(conversationId).listen(
      (messages) {
        _currentMessages = messages;
        notifyListeners();
      },
    );
  }

  /// Stop listening to messages
  void stopListening() {
    _messagesSubscription?.cancel();
    _messagesSubscription = null;
    _currentMessages = [];
  }

  /// Send a message
  Future<void> sendMessage(String receiverId, String content) async {
    if (_currentUserId == null || content.trim().isEmpty) return;

    try {
      final conversationId = _firebase.getConversationId(_currentUserId!, receiverId);
      
      // Create conversation document if it doesn't exist
      await _firebase.createConversationIfNeeded(_currentUserId!, receiverId);
      
      final message = Message(
        id: '',
        senderId: _currentUserId!,
        receiverId: receiverId,
        content: content.trim(),
        timestamp: DateTime.now(),
      );

      await _firebase.sendMessage(conversationId, message);
    } catch (e) {
      // Message failed to send — silently handle
    }
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    _conversationsSubscription?.cancel();
    super.dispose();
  }
}

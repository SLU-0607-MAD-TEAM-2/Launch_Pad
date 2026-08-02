import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_profile.dart';
import '../models/startup_project.dart';
import '../models/match_model.dart';
import '../models/message.dart';
import '../models/application.dart';

class FirebaseDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  // ── Users ──

  Future<UserProfile?> getCurrentUser() async {
    if (_currentUserId == null) return null;
    final doc = await _db.collection('users').doc(_currentUserId).get();
    if (!doc.exists || doc.data() == null) return null;
    final data = doc.data()!;
    data['id'] = _currentUserId;
    return UserProfile.fromJson(data);
  }

  Future<UserProfile?> getUserById(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    final data = doc.data()!;
    data['id'] = userId;
    return UserProfile.fromJson(data);
  }

  Future<List<UserProfile>> getUsers() async {
    final snapshot = await _db.collection('users').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return UserProfile.fromJson(data);
    }).toList();
  }

  Stream<List<UserProfile>> watchUsers() {
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return UserProfile.fromJson(data);
      }).toList();
    });
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    await _db.collection('users').doc(profile.id).update(profile.toJson());
  }

  // ── Projects ──

  Future<List<StartupProject>> getProjects() async {
    final snapshot = await _db.collection('projects').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return StartupProject.fromJson(data);
    }).toList();
  }

  Stream<List<StartupProject>> watchProjects() {
    return _db.collection('projects').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return StartupProject.fromJson(data);
      }).toList();
    });
  }

  // ── Matches ──

  Future<List<MatchModel>> getMatches(String userId) async {
    final snapshot = await _db
        .collection('matches')
        .where('participants', arrayContains: userId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return MatchModel.fromJson(data);
    }).toList();
  }

  Stream<List<MatchModel>> watchMatches(String userId) {
    return _db
        .collection('matches')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return MatchModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> createMatch(String userId, String matchedUserId) async {
    await _db.collection('matches').add({
      'userId': userId,
      'matchedUserId': matchedUserId,
      'participants': [userId, matchedUserId],
      'createdAt': FieldValue.serverTimestamp(),
      'isMutual': true,
    });
  }

  // ── Messages ──

  Stream<List<Message>> watchMessages(String conversationId) {
    return _db
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Message.fromJson(data);
      }).toList();
    });
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final snapshot = await _db
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Message.fromJson(data);
    }).toList();
  }

  Future<void> sendMessage(String conversationId, Message message) async {
    await _db
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .add({
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'content': message.content,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  /// Create conversation document if it doesn't exist
  Future<void> createConversationIfNeeded(String userId1, String userId2) async {
    final conversationId = getConversationId(userId1, userId2);
    final doc = await _db.collection('conversations').doc(conversationId).get();
    
    if (!doc.exists) {
      await _db.collection('conversations').doc(conversationId).set({
        'participants': [userId1, userId2],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  String getConversationId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_${userId2}'
        : '${userId2}_${userId1}';
  }

  // ── Conversations List ──

  /// Get all conversations for current user with last message preview
  Future<List<Map<String, dynamic>>> getConversations() async {
    if (_currentUserId == null) return [];

    final snapshot = await _db
        .collection('conversations')
        .where('participants', arrayContains: _currentUserId)
        .get();

    final conversations = <Map<String, dynamic>>[];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final participants = List<String>.from(data['participants'] ?? []);
      final otherUserId = participants.firstWhere(
        (id) => id != _currentUserId,
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

    return conversations;
  }

  // ── Applications ──

  Future<List<Application>> getApplicationsForProject(String projectId) async {
    final snapshot = await _db
        .collection('applications')
        .where('projectId', isEqualTo: projectId)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Application.fromJson(data);
    }).toList();
  }

  Future<void> submitApplication(Application app) async {
    await _db.collection('applications').add({
      'projectId': app.projectId,
      'projectName': app.projectName,
      'applicantId': app.applicantId,
      'coverNote': app.coverNote,
      'appliedAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
  }

  // ── Image Upload ──

  /// Upload profile avatar from XFile (works on both web and mobile)
  Future<String?> uploadAvatarFromXFile(XFile xFile) async {
    if (_currentUserId == null) return null;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('avatars')
          .child('$_currentUserId.jpg');

      // Read bytes from XFile (works on both web and mobile)
      final bytes = await xFile.readAsBytes();

      await ref.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await ref.getDownloadURL();

      // Update user profile with new avatar URL
      await _db.collection('users').doc(_currentUserId).update({
        'avatarUrl': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}

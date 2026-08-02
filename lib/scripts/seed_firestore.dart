import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Seeds Firestore with data from JSON assets.
/// Run automatically on first launch if users collection is empty.
class SeedFirestore {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> run() async {
    try {
      // Check if already seeded
      final existing = await _db.collection('users').limit(1).get();
      if (existing.docs.isNotEmpty) {
        return; // Already seeded
      }

      // Load JSON files
      final profilesJson = await rootBundle.loadString('assets/data/profiles.json');
      final projectsJson = await rootBundle.loadString('assets/data/projects.json');
      final matchesJson = await rootBundle.loadString('assets/data/matches.json');
      final applicationsJson = await rootBundle.loadString('assets/data/applications.json');

      final profiles = jsonDecode(profilesJson) as List<dynamic>;
      final projects = jsonDecode(projectsJson) as List<dynamic>;
      final matches = jsonDecode(matchesJson) as List<dynamic>;
      final applications = jsonDecode(applicationsJson) as List<dynamic>;

      // Seed users
      for (final profile in profiles) {
        final data = Map<String, dynamic>.from(profile);
        final id = data.remove('id');
        await _db.collection('users').doc(id).set(data);
      }

      // Seed projects
      for (final project in projects) {
        final data = Map<String, dynamic>.from(project);
        final id = data.remove('id');
        await _db.collection('projects').doc(id).set(data);
      }

      // Seed matches
      for (final match in matches) {
        final data = Map<String, dynamic>.from(match);
        data['participants'] = [data['userId'], data['matchedUserId']];
        await _db.collection('matches').add(data);
      }

      // Seed conversations between users (p1-p5)
      await _seedConversations();

      // Seed applications
      for (final app in applications) {
        final data = Map<String, dynamic>.from(app);
        data.remove('id');
        await _db.collection('applications').add(data);
      }

      print('Firestore seeded successfully with:');
      print('  - ${profiles.length} users');
      print('  - ${projects.length} projects');
      print('  - ${matches.length} matches');
      print('  - 3 conversations with messages');
      print('  - ${applications.length} applications');
    } catch (e) {
      print('Error seeding Firestore: $e');
    }
  }

  static Future<void> _seedConversations() async {
    // Conversation between p1 (Sarah) and p2 (Marcus)
    final conv1Id = 'p1_p2';
    await _db.collection('conversations').doc(conv1Id).set({
      'participants': ['p1', 'p2'],
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('conversations').doc(conv1Id).collection('messages').add({
      'senderId': 'p1',
      'receiverId': 'p2',
      'content': 'Hey Marcus! I saw you\'re looking for a technical co-founder. I\'d love to chat about your project.',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });
    await _db.collection('conversations').doc(conv1Id).collection('messages').add({
      'senderId': 'p2',
      'receiverId': 'p1',
      'content': 'Hi Sarah! Yes, we\'re building something exciting in the EdTech space. Would love to discuss further!',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });
    await _db.collection('conversations').doc(conv1Id).collection('messages').add({
      'senderId': 'p1',
      'receiverId': 'p2',
      'content': 'That sounds great! I have experience with Flutter and Firebase. Let\'s schedule a call.',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // Conversation between p3 (Emily) and p5 (Aisha)
    final conv2Id = 'p3_p5';
    await _db.collection('conversations').doc(conv2Id).set({
      'participants': ['p3', 'p5'],
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('conversations').doc(conv2Id).collection('messages').add({
      'senderId': 'p3',
      'receiverId': 'p5',
      'content': 'Love your design portfolio! Would you be interested in collaborating on a SaaS project?',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });
    await _db.collection('conversations').doc(conv2Id).collection('messages').add({
      'senderId': 'p5',
      'receiverId': 'p3',
      'content': 'Thanks Emily! I\'m always open to new opportunities. What\'s the project about?',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });

    // Conversation between p2 (Marcus) and p4 (David)
    final conv3Id = 'p2_p4';
    await _db.collection('conversations').doc(conv3Id).set({
      'participants': ['p2', 'p4'],
      'createdAt': FieldValue.serverTimestamp(),
    });
    await _db.collection('conversations').doc(conv3Id).collection('messages').add({
      'senderId': 'p2',
      'receiverId': 'p4',
      'content': 'Hey David! Your video editing skills are impressive. We need a content creator for our startup.',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });
    await _db.collection('conversations').doc(conv3Id).collection('messages').add({
      'senderId': 'p4',
      'receiverId': 'p2',
      'content': 'Thanks Marcus! I\'d love to hear more about the project. What kind of content are you looking for?',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': true,
    });
    await _db.collection('conversations').doc(conv3Id).collection('messages').add({
      'senderId': 'p2',
      'receiverId': 'p4',
      'content': 'We need demo videos, social media content, and product walkthroughs. Interested?',
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }
}

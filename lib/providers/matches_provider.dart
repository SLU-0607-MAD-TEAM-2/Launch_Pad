import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';
import '../models/match_model.dart';
import '../services/firebase_data_service.dart';

class MatchesProvider extends ChangeNotifier {
  final FirebaseDataService _firebase = FirebaseDataService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<MatchModel> _matches = [];
  List<UserProfile> _matchedUsers = [];

  List<MatchModel> get matches => _matches;
  List<UserProfile> get matchedUsers => _matchedUsers;
  bool get isEmpty => _matches.isEmpty;

  Future<void> loadMatches() async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return;

    try {
      _matches = await _firebase.getMatches(currentUserId);

      // Fetch user profiles for matched users
      _matchedUsers = [];
      for (final match in _matches) {
        final userId = match.matchedUserId == currentUserId
            ? match.userId
            : match.matchedUserId;
        final user = await _firebase.getUserById(userId);
        if (user != null) {
          _matchedUsers.add(user);
        }
      }
    } catch (e) {
      _matches = [];
      _matchedUsers = [];
    }
    notifyListeners();
  }

  UserProfile? getUserById(String id) {
    try {
      return _matchedUsers.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }
}

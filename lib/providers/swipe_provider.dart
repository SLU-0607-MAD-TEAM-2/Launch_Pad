import 'package:flutter/material.dart';
import '../models/startup_project.dart';
import '../services/firestore_service.dart';

class SwipeProvider extends ChangeNotifier {
  final FirestoreService _firestore;
  List<StartupProject> _candidates = [];
  int _currentIndex = 0;
  final List<String> _likedIds = [];
  final List<String> _dislikedIds = [];

  SwipeProvider(this._firestore) {
    _loadCandidates();
  }

  List<StartupProject> get candidates => _candidates;
  int get currentIndex => _currentIndex;
  StartupProject? get current =>
      _currentIndex < _candidates.length ? _candidates[_currentIndex] : null;
  bool get isEmpty => _currentIndex >= _candidates.length;
  int get totalCount => _candidates.length;
  int get likedCount => _likedIds.length;

  void _loadCandidates() {
    _candidates = List.from(_firestore.getProjects());
    _candidates.shuffle();
    _currentIndex = 0;
    _likedIds.clear();
    _dislikedIds.clear();
  }

  void swipeRight() {
    if (current != null) {
      _likedIds.add(current!.id);
      _currentIndex++;
      notifyListeners();
    }
  }

  void swipeLeft() {
    if (current != null) {
      _dislikedIds.add(current!.id);
      _currentIndex++;
      notifyListeners();
    }
  }

  void reset() {
    _loadCandidates();
    notifyListeners();
  }

  List<StartupProject> get likedProjects =>
      _candidates.where((u) => _likedIds.contains(u.id)).toList();
}

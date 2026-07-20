import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/mock_api_service.dart';

class SwipeProvider extends ChangeNotifier {
  final List<UserProfile> _deck = [];
  final List<UserProfile> _matches = [];
  final List<UserProfile> _passed = [];

  double _dragDx = 0.0;
  double _dragDy = 0.0;
  bool _showMatchOverlay = false;
  UserProfile? _lastMatch;
  final MockApiService _apiService;

  SwipeProvider(this._apiService) {
    _deck.addAll(List.from(_apiService.swipeProfiles));
  }

  List<UserProfile> get deck => _deck;
  List<UserProfile> get matches => _matches;
  List<UserProfile> get passed => _passed;

  UserProfile? get currentProfile => _deck.isNotEmpty ? _deck.first : null;

  double get dragDx => _dragDx;
  double get dragDy => _dragDy;
  bool get showMatchOverlay => _showMatchOverlay;
  UserProfile? get lastMatch => _lastMatch;

  bool get isDeckEmpty => _deck.isEmpty;

  void updateDrag(double dx, double dy) {
    _dragDx = dx;
    _dragDy = dy;
    notifyListeners();
  }

  void resetDrag() {
    _dragDx = 0.0;
    _dragDy = 0.0;
    notifyListeners();
  }

  void swipeRight() {
    if (_deck.isEmpty) return;
    final matched = _deck.first;
    _matches.add(matched);
    _lastMatch = matched;
    _deck.removeAt(0);
    _dragDx = 0.0;
    _dragDy = 0.0;
    _showMatchOverlay = true;
    notifyListeners();
  }

  void swipeLeft() {
    if (_deck.isEmpty) return;
    _passed.add(_deck.first);
    _deck.removeAt(0);
    _dragDx = 0.0;
    _dragDy = 0.0;
    notifyListeners();
  }

  void superLike() {
    if (_deck.isEmpty) return;
    final liked = _deck.first;
    _matches.insert(0, liked);
    _lastMatch = liked;
    _deck.removeAt(0);
    _dragDx = 0.0;
    _dragDy = 0.0;
    notifyListeners();
  }

  void dismissMatchOverlay() {
    _showMatchOverlay = false;
    notifyListeners();
  }

  void reloadDeck() {
    _deck
      ..clear()
      ..addAll(List.from(_apiService.swipeProfiles));
    _matches.clear();
    _passed.clear();
    _showMatchOverlay = false;
    notifyListeners();
  }

  void undo() {
    if (_passed.isEmpty) return;
    final lastPassed = _passed.removeLast();
    _deck.insert(0, lastPassed);
    notifyListeners();
  }
}

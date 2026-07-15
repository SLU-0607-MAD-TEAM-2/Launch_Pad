import 'package:flutter/material.dart';
import '../models/user_profile.dart';

/// SwipeProvider manages the state of the swipe deck:
/// - The ordered deck of profiles
/// - Matched profiles
/// - The current card's drag offset and rotation
class SwipeProvider extends ChangeNotifier {
  final List<UserProfile> _deck = List.from(mockSwipeProfiles);
  final List<UserProfile> _matches = [];
  final List<UserProfile> _passed = [];

  double _dragDx = 0.0;
  double _dragDy = 0.0;
  bool _showMatchOverlay = false;
  UserProfile? _lastMatch;

  // --- Getters ---

  List<UserProfile> get deck => _deck;
  List<UserProfile> get matches => _matches;
  List<UserProfile> get passed => _passed;

  UserProfile? get currentProfile => _deck.isNotEmpty ? _deck.first : null;

  double get dragDx => _dragDx;
  double get dragDy => _dragDy;
  bool get showMatchOverlay => _showMatchOverlay;
  UserProfile? get lastMatch => _lastMatch;

  bool get isDeckEmpty => _deck.isEmpty;

  // --- Drag state ---

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

  // --- Swipe actions ---

  /// Swipe right — it's a match!
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

  /// Swipe left — pass.
  void swipeLeft() {
    if (_deck.isEmpty) return;
    _passed.add(_deck.first);
    _deck.removeAt(0);
    _dragDx = 0.0;
    _dragDy = 0.0;
    notifyListeners();
  }

  /// Star / Super-like — add to matches with priority flag.
  void superLike() {
    if (_deck.isEmpty) return;
    final liked = _deck.first;
    _matches.insert(0, liked); // Priority placement
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

  /// Reload the deck (for demo reset).
  void reloadDeck() {
    _deck.addAll(List.from(mockSwipeProfiles));
    _matches.clear();
    _passed.clear();
    _showMatchOverlay = false;
    notifyListeners();
  }
}

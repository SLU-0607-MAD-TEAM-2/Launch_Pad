import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

import '../data/sample_data.dart';

class DiscoveryProvider extends ChangeNotifier {
  List<UserProfile> _profiles = [];
  bool _isLoading = false;
  String? _lastSwipedId;

  List<UserProfile> get profiles => _profiles;
  bool get isLoading => _isLoading;
  bool get isEmpty => _profiles.isEmpty;
  String? get lastSwipedId => _lastSwipedId;

  void loadProfiles() {
    _isLoading = true;
    notifyListeners();
    _profiles = List.from(SampleData.profiles)..shuffle();
    _isLoading = false;
    notifyListeners();
  }

  void swipeLeft(String id) {
    _lastSwipedId = id;
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void swipeRight(String id) {
    _lastSwipedId = id;
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void superLike(String id) {
    _lastSwipedId = id;
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void reload() {
    loadProfiles();
  }
}

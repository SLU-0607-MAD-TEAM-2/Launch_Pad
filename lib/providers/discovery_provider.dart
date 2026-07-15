import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/startup_project.dart';
import '../services/mock_api_service.dart';

class DiscoveryProvider extends ChangeNotifier {
  final MockApiService _apiService;
  List<UserProfile> _profiles = [];
  bool _isLoading = false;
  String? _lastSwipedId;

  DiscoveryProvider(this._apiService);

  List<UserProfile> get profiles => _profiles;
  List<StartupProject> get projects => _apiService.projects;
  bool get isLoading => _isLoading;
  bool get isEmpty => _profiles.isEmpty;
  String? get lastSwipedId => _lastSwipedId;

  void loadProfiles() {
    _isLoading = true;
    notifyListeners();
    _profiles = List.from(_apiService.profiles)..shuffle();
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

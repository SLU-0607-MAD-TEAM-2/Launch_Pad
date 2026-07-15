import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/match_model.dart';
import '../services/mock_api_service.dart';

class MatchesProvider extends ChangeNotifier {
  final MockApiService _apiService;
  List<MatchModel> _matches = [];
  Map<String, UserProfile> _userMap = {};

  MatchesProvider(this._apiService);

  List<MatchModel> get matches => _matches;
  bool get isEmpty => _matches.isEmpty;

  void loadMatches() {
    _matches = List.from(_apiService.matches);
    _userMap = {};
    for (final p in _apiService.profiles) {
      _userMap[p.id] = p;
    }
    notifyListeners();
  }

  UserProfile? getUserById(String id) => _userMap[id];

  void addMatch(MatchModel m) {
    _matches.insert(0, m);
    notifyListeners();
  }
}

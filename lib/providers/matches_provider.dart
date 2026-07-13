import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/match_model.dart';
import '../data/sample_data.dart';

class MatchesProvider extends ChangeNotifier {
  List<MatchModel> _matches = [];
  Map<String, UserProfile> _userMap = {};

  List<MatchModel> get matches => _matches;
  bool get isEmpty => _matches.isEmpty;

  void loadMatches() {
    _matches = SampleData.matches;
    _userMap = {};
    for (final p in SampleData.profiles) {
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

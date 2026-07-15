import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/user_profile.dart';
import '../models/startup_project.dart';
import '../models/match_model.dart';
import '../models/message.dart';
import '../models/application.dart';

class MockApiService {
  List<UserProfile> _profiles = [];
  List<StartupProject> _projects = [];
  List<MatchModel> _matches = [];
  Map<String, List<Message>> _conversations = {};
  List<Application> _applications = [];
  bool _isLoaded = false;
  bool _hasError = false;
  String? _errorMessage;

  List<UserProfile> get profiles => _profiles;
  List<StartupProject> get projects => _projects;
  List<MatchModel> get matches => _matches;
  List<Application> get applications => _applications;
  bool get isLoaded => _isLoaded;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  List<Message> messagesFor(String userId) => _conversations[userId] ?? [];

  UserProfile? profileById(String id) {
    try {
      return _profiles.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  UserProfile? get currentUser {
    try {
      return _profiles.firstWhere((p) => p.id == 'current_user');
    } catch (_) {
      return null;
    }
  }

  List<UserProfile> get swipeProfiles =>
      _profiles.where((p) => p.id != 'current_user').toList();

  Future<void> loadAll() async {
    try {
      final profilesJson =
          await rootBundle.loadString('assets/data/profiles.json');
      _profiles =
          (jsonDecode(profilesJson) as List)
              .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
              .toList();

      final projectsJson =
          await rootBundle.loadString('assets/data/projects.json');
      _projects =
          (jsonDecode(projectsJson) as List)
              .map((e) => StartupProject.fromJson(e as Map<String, dynamic>))
              .toList();

      final matchesJson =
          await rootBundle.loadString('assets/data/matches.json');
      _matches =
          (jsonDecode(matchesJson) as List)
              .map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
              .toList();

      final messagesJson =
          await rootBundle.loadString('assets/data/messages.json');
      final msgsMap = jsonDecode(messagesJson) as Map<String, dynamic>;
      _conversations = msgsMap.map((k, v) =>
          MapEntry(k,
              (v as List).map((e) => Message.fromJson(e as Map<String, dynamic>)).toList()));

      final appsJson =
          await rootBundle.loadString('assets/data/applications.json');
      _applications =
          (jsonDecode(appsJson) as List)
              .map((e) => Application.fromJson(e as Map<String, dynamic>))
              .toList();

      _isLoaded = true;
      _hasError = false;
      _errorMessage = null;
    } catch (e) {
      _isLoaded = false;
      _hasError = true;
      _errorMessage = 'Failed to load data: $e';
    }
  }
}

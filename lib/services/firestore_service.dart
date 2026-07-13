import '../models/user_profile.dart';
import '../models/startup_project.dart';
import '../models/application.dart';
import '../data/sample_data.dart';

class FirestoreService {
  final List<UserProfile> _users = SampleData.profiles;
  final List<StartupProject> _projects = StartupProject.sampleProjects();
  final List<Application> _applications = Application.sampleApplications();
  final Map<String, List<String>> _matches = {
    'u1': ['u2'],
    'u2': ['u1', 'u3'],
    'u3': ['u2'],
    'u4': ['u7'],
    'u7': ['u4'],
  };
  final Map<String, List<Map<String, dynamic>>> _messages = {
    'u1-u2': [
      {'senderId': 'u1', 'text': 'Hey Sophie! Love your profile. Would you be interested in joining LearnAI?', 'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String()},
      {'senderId': 'u2', 'text': 'Hi Alex! Yes, I\'m very interested. The edtech space is exactly where I want to be.', 'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 45)).toIso8601String()},
      {'senderId': 'u1', 'text': 'Awesome! Let\'s schedule a quick call this week to discuss.', 'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)).toIso8601String()},
    ],
    'u2-u3': [
      {'senderId': 'u3', 'text': 'Hey Sophie! I saw your profile and I think we\'d make a great team.', 'timestamp': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String()},
      {'senderId': 'u2', 'text': 'Thanks Marcus! What project are you working on?', 'timestamp': DateTime.now().subtract(const Duration(hours: 4, minutes: 30)).toIso8601String()},
    ],
    'u4-u7': [
      {'senderId': 'u7', 'text': 'Hi Priya! I\'d love to contribute to GreenRoute. My ML experience could really help.', 'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()},
      {'senderId': 'u4', 'text': 'That sounds great David! Let\'s connect this week.', 'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()},
    ],
  };

  List<UserProfile> getUsers() => List.unmodifiable(_users);

  List<StartupProject> getProjects() => List.unmodifiable(_projects);

  List<StartupProject> getProjectsByFounder(String userId) {
    return _projects.where((p) => p.founderId == userId).toList();
  }

  List<Application> getApplicationsForProject(String projectId) {
    return _applications.where((a) => a.projectId == projectId).toList();
  }

  List<Application> getApplicationsByUser(String userId) {
    return _applications.where((a) => a.applicantId == userId).toList();
  }

  List<UserProfile> getMatches(String userId) {
    final matchIds = _matches[userId] ?? [];
    return _users.where((u) => matchIds.contains(u.id)).toList();
  }

  List<Map<String, dynamic>> getMessages(String user1Id, String user2Id) {
    final key1 = '${user1Id}-${user2Id}';
    final key2 = '${user2Id}-${user1Id}';
    return _messages[key1] ?? _messages[key2] ?? [];
  }

  List<UserProfile> getUsersByRole(String role) {
    return _users.where((u) => u.role.name == role).toList();
  }

  void addMatch(String userId, String matchedId) {
    _matches.putIfAbsent(userId, () => []);
    _matches[userId]!.add(matchedId);
  }

  void addApplication(Application app) {
    _applications.add(app);
  }

  void sendMessage(String senderId, String receiverId, String text) {
    final key = senderId.compareTo(receiverId) < 0
        ? '${senderId}-${receiverId}'
        : '${receiverId}-${senderId}';
    _messages.putIfAbsent(key, () => []);
    _messages[key]!.add({
      'senderId': senderId,
      'text': text,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  List<UserProfile> searchUsers({
    String? query,
    String? roleFilter,
    String? skillFilter,
  }) {
    var results = _users;
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      results = results.where((u) =>
        u.name.toLowerCase().contains(q) ||
        (u.headline ?? '').toLowerCase().contains(q) ||
        u.skills.any((s) => s.toLowerCase().contains(q))
      ).toList();
    }
    if (roleFilter != null && roleFilter != 'all') {
      results = results.where((u) => u.role.name == roleFilter).toList();
    }
    if (skillFilter != null && skillFilter.isNotEmpty) {
      results = results.where((u) =>
        u.skills.any((s) => s.toLowerCase().contains(skillFilter.toLowerCase()))
      ).toList();
    }
    return results;
  }

  List<StartupProject> searchProjects({
    String? query,
    String? stageFilter,
    String? roleFilter,
  }) {
    var results = _projects;
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      results = results.where((p) =>
        p.title.toLowerCase().contains(q) ||
        p.description.toLowerCase().contains(q) ||
        p.industry.toLowerCase().contains(q)
      ).toList();
    }
    if (stageFilter != null && stageFilter != 'all') {
      results = results.where((p) => p.stage == stageFilter).toList();
    }
    if (roleFilter != null && roleFilter != 'all') {
      results = results.where((p) =>
        p.rolesNeeded.contains(roleFilter)
      ).toList();
    }
    return results;
  }
}

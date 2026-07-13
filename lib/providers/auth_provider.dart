import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../models/enums.dart';

class AuthProvider extends ChangeNotifier {
  UserProfile? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  UserProfile? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = UserProfile(
      id: 'current_user',
      name: 'Alex Morgan',
      email: email,
      role: Role.founder,
      headline: 'Building the next big thing',
      bio: 'Serial entrepreneur with 2 exits. Currently focused on AI-powered developer tools.',
      skills: ['Python', 'Swift', 'React', 'Product Strategy', 'Fundraising'],
      experienceLevel: ExperienceLevel.senior,
      interests: ['AI/ML', 'SaaS', 'Developer Tools'],
      location: 'San Francisco, CA',
      isLookingForTeam: true,
    );
    _isLoading = false;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = UserProfile(
      id: 'current_user',
      name: name,
      email: email,
      role: Role.developer,
      isLookingForTeam: true,
    );
    _isLoading = false;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updated) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = updated;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}

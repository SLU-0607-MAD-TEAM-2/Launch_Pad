import '../models/user_profile.dart';
import '../models/enums.dart';
import '../data/sample_data.dart';

class AuthService {
  UserProfile? _currentUser;

  UserProfile? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = SampleData.profiles.firstWhere(
      (u) => u.email == email,
      orElse: () => SampleData.profiles.first,
    );
  }

  Future<void> signUp(String name, String email, String password, String role) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = UserProfile(
      id: 'u${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      role: roleFromString(role) ?? Role.founder,
    );
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<void> updateProfile(UserProfile updated) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = updated;
  }
}

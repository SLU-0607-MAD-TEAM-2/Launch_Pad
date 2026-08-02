import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import '../models/enums.dart';

class AuthProvider extends ChangeNotifier {
  UserProfile? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _errorMessage;

  UserProfile? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
      return;
    }
    await _loadUserProfile(firebaseUser.uid);
  }

  Future<void> _loadUserProfile(String uid) async {
    try {
      // Reload user to get latest displayName
      await _auth.currentUser?.reload();
      final freshUser = _auth.currentUser;

      final doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['id'] = uid;
        // Use Firestore name if available, otherwise fall back to Auth displayName
        if (data['name'] == null || data['name'].toString().isEmpty) {
          data['name'] = freshUser?.displayName ?? 'User';
        }
        _currentUser = UserProfile.fromJson(data);
      } else {
        _currentUser = UserProfile(
          id: uid,
          name: freshUser?.displayName ?? 'User',
          email: freshUser?.email ?? '',
          role: Role.founder,
        );
      }
      _isLoggedIn = true;
    } catch (e) {
      final freshUser = _auth.currentUser;
      _currentUser = UserProfile(
        id: uid,
        name: freshUser?.displayName ?? 'User',
        email: freshUser?.email ?? '',
        role: Role.founder,
      );
      _isLoggedIn = true;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Login failed';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final googleProvider = GoogleAuthProvider();
      googleProvider.setCustomParameters({'prompt': 'select_account'});
      await _auth.signInWithPopup(googleProvider);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user' || e.code == 'cancelled-popup-request') {
        _errorMessage = null; // User closed popup — not an error
      } else {
        _errorMessage = e.message ?? 'Google sign-in failed';
      }
    } catch (e) {
      _errorMessage = 'Google sign-in failed. Try email/password instead.';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user?.updateDisplayName(name);
      await _db.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'founder',
        'headline': '',
        'bio': '',
        'skills': [],
        'experienceLevel': 'entry',
        'interests': [],
        'location': '',
        'isLookingForTeam': true,
        'avatarUrl': '',
        'isVerified': false,
      });
      // Reload user to get updated displayName
      await cred.user?.reload();
      // Explicitly load the profile after sign-up
      await _loadUserProfile(cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Sign up failed';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfileRole(String role) async {
    if (_currentUser == null) return;
    try {
      await _db.collection('users').doc(_currentUser!.id).update({'role': role});
      _currentUser = _currentUser!.copyWith(
        role: roleFromString(role) ?? Role.founder,
      );
      notifyListeners();
    } catch (e) {
      // Silently fail — role update is non-critical
    }
  }

  Future<void> updateProfile(UserProfile updated) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _db.collection('users').doc(updated.id).update(updated.toJson());
      _currentUser = updated;
    } catch (e) {
      _errorMessage = 'Failed to update profile';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}

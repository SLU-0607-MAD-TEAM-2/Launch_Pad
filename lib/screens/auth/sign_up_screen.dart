import 'package:flutter/material.dart';
import '../../utils/design_colors.dart';
import 'role_selection_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscured = true;
  bool _confirmObscured = true;

  void _signUp() {
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty ||
        _passwordCtrl.text.isEmpty || _confirmCtrl.text.isEmpty) return;
    if (_passwordCtrl.text != _confirmCtrl.text) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RoleSelectionScreen(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DesignColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 72, height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [DesignColors.primary, DesignColors.secondary],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Icon(Icons.rocket_launch, color: Colors.white, size: 36),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text('Create Account', style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w700, color: DesignColors.textPrimary,
                )),
              ),
              const SizedBox(height: 8),
              const Center(child: Text('Join LaunchPad and find your team', style: TextStyle(
                fontSize: 14, color: DesignColors.textSecondary,
              ))),
              const SizedBox(height: 36),
              const Text('Full Name', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
              )),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DesignColors.border),
                ),
                child: TextField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    hintText: 'John Doe',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Email', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
              )),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DesignColors.border),
                ),
                child: TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    hintText: 'you@example.com',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Password', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
              )),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DesignColors.border),
                ),
                child: TextField(
                  controller: _passwordCtrl,
                  obscureText: _obscured,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(_obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: DesignColors.textSecondary),
                      onPressed: () => setState(() => _obscured = !_obscured),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Confirm Password', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
              )),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: DesignColors.border),
                ),
                child: TextField(
                  controller: _confirmCtrl,
                  obscureText: _confirmObscured,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(_confirmObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: DesignColors.textSecondary),
                      onPressed: () => setState(() => _confirmObscured = !_confirmObscured),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Divider(color: DesignColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or sign up with', style: TextStyle(
                      fontSize: 12, color: DesignColors.textSecondary,
                    )),
                  ),
                  const Expanded(child: Divider(color: DesignColors.border)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity, height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 24, color: DesignColors.textPrimary),
                  label: const Text('Google', style: TextStyle(color: DesignColors.textPrimary)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: DesignColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity, height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple, size: 24, color: DesignColors.textPrimary),
                  label: const Text('Apple', style: TextStyle(color: DesignColors.textPrimary)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: DesignColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(
                      color: DesignColors.textSecondary, fontSize: 14,
                    )),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Sign In', style: TextStyle(
                        color: DesignColors.primary, fontWeight: FontWeight.w600, fontSize: 14,
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }
}

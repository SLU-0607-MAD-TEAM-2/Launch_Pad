import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/app_input.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.accent,
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text('Launch Pad', style: AppTypography.displayMedium),
                const SizedBox(height: 8),
                Text(
                  'Find your perfect co-founder',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 48),
                AppInput(
                  label: 'Email',
                  hint: 'you@example.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AppInput(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordCtrl,
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Sign In',
                  isLoading: auth.isLoading,
                  onPressed: () => auth.login(
                    _emailCtrl.text.trim(),
                    _passwordCtrl.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../utils/design_colors.dart';
import '../home/main_shell.dart';

class RoleSelectionScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const RoleSelectionScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  static const List<String> _roles = [
    'founder', 'developer', 'creative', 'marketer', 'operator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: DesignColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Choose your role',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: DesignColors.textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pick the role that best describes you. You can always update this later.',
                style: const TextStyle(
                  fontSize: 14,
                  color: DesignColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              ..._roles.map((role) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _RoleCard(
                  role: role,
                  isSelected: _selectedRole == role,
                  onTap: () => setState(() => _selectedRole = role),
                ),
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedRole != null && !_isLoading ? _onContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignColors.primary,
                    disabledBackgroundColor: DesignColors.primary.withValues(alpha: 0.4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                    ? const SizedBox(
                        width: 22, height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Continue',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    setState(() => _isLoading = true);
    try {
      final auth = context.read<AuthProvider>();
      await auth.signUp(widget.name, widget.email, widget.password);
      await auth.updateProfileRole(_selectedRole!);

      // Create a conversation with a seeded user so messages appear
      final currentUserId = auth.currentUser?.id;
      if (currentUserId != null) {
        await _createWelcomeConversation(currentUserId);
      }

      // Wait for profile to be loaded
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainShell()),
          (route) => false,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createWelcomeConversation(String userId) async {
    try {
      final db = FirebaseFirestore.instance;
      // Create conversation with seeded user p1 (Sarah Chen)
      final conversationId = '${userId}_p1';
      await db.collection('conversations').doc(conversationId).set({
        'participants': [userId, 'p1'],
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Add welcome messages
      await db.collection('conversations').doc(conversationId).collection('messages').add({
        'senderId': 'p1',
        'receiverId': userId,
        'content': 'Hey! Welcome to LaunchPad! I saw you just joined — love your profile!',
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': true,
      });
      await db.collection('conversations').doc(conversationId).collection('messages').add({
        'senderId': 'p1',
        'receiverId': userId,
        'content': 'I\'m working on an AI-powered code review tool. Would love your input!',
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      // Also create a match record
      await db.collection('matches').add({
        'userId': userId,
        'matchedUserId': 'p1',
        'participants': [userId, 'p1'],
        'createdAt': FieldValue.serverTimestamp(),
        'isMutual': true,
      });
    } catch (e) {
      // Silently fail — conversation creation is non-critical
    }
  }
}

class _RoleCard extends StatelessWidget {
  final String role;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = DesignColors.roleColors[role] ?? DesignColors.primary;
    final icon = DesignColors.roleIcons[role] ?? Icons.workspace_premium;
    final label = DesignColors.roleLabels[role] ?? role;
    final subtitle = DesignColors.roleSubtitles[role] ?? '';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? color : DesignColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    DesignColors.roleGradients[role] ?? color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DesignColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: DesignColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22, height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? color : Colors.transparent,
                border: Border.all(
                  color: isSelected ? color : DesignColors.textSecondary.withValues(alpha: 0.5),
                  width: isSelected ? 0 : 2,
                ),
              ),
              child: isSelected
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
            ),
          ],
        ),
      ),
    );
  }
}

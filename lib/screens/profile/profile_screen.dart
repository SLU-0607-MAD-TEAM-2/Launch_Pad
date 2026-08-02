import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../providers/auth_provider.dart';
import '../../utils/app_theme.dart';
import 'edit_profile_screen.dart';
import '../../widgets/scale_tap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    // Use actual user data or fallback to defaults
    final name = user?.name ?? FirebaseAuth.instance.currentUser?.displayName ?? 'User';
    final location = user?.location ?? '';
    final bio = user?.bio ?? '';
    final role = user?.role.name ?? '';
    final github = user?.githubUrl ?? '';
    final linkedin = user?.linkedInUrl ?? '';
    final avatarUrl = user?.avatarUrl ?? '';
    final skills = user?.skills ?? [];

    final completionVal = _getCompletionPercentage(name, location, bio, skills);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Profile', style: theme.textTheme.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20),

            // ── Avatar ──────────────────────────────────────────
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColor.primaryBlue, AppColor.accentCyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryBlue.withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: avatarUrl.isNotEmpty
                          ? NetworkImage(avatarUrl)
                          : null,
                      backgroundColor: theme.colorScheme.surface,
                      child: avatarUrl.isEmpty
                          ? Text(
                              name.isNotEmpty ? name[0].toUpperCase() : '?',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryBlue,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.primaryBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.colorScheme.surface, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Name + Role ─────────────────────────────────────
            Center(
              child: Text(
                name,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  role.isNotEmpty ? role : 'No role set',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColor.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // ── Location ────────────────────────────────────────
            if (location.isNotEmpty) ...[
              const SizedBox(height: 12),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.location, size: 16, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // ── Profile Completion ──────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Profile Completion', style: theme.textTheme.titleSmall),
                      Text(
                        '${(completionVal * 100).toInt()}%',
                        style: theme.textTheme.titleSmall?.copyWith(color: AppColor.primaryBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: completionVal,
                      minHeight: 8,
                      backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColor.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Bio ─────────────────────────────────────────────
            if (bio.isNotEmpty) ...[
              Text('ABOUT', style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 1.4,
              )),
              const SizedBox(height: 8),
              Text(bio, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 24),
            ],

            // ── Skills ──────────────────────────────────────────
            if (skills.isNotEmpty) ...[
              Text('TECHNICAL ARSENAL', style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 1.4,
              )),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColor.skillBlueBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.primaryBlue.withValues(alpha: 0.15)),
                    ),
                    child: Text(
                      skill,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColor.skillBlueText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // ── Links ───────────────────────────────────────────
            if (github.isNotEmpty || linkedin.isNotEmpty) ...[
              Text('CONNECT', style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 1.4,
              )),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (github.isNotEmpty)
                    _LinkChip(
                      icon: Iconsax.code,
                      label: 'GitHub',
                      url: github,
                      theme: theme,
                    ),
                  if (github.isNotEmpty && linkedin.isNotEmpty)
                    const SizedBox(width: 10),
                  if (linkedin.isNotEmpty)
                    _LinkChip(
                      icon: Iconsax.link,
                      label: 'LinkedIn',
                      url: linkedin,
                      theme: theme,
                    ),
                ],
              ),
              const SizedBox(height: 24),
            ],

            // ── Edit Profile Button ─────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        initialName: name,
                        initialLocation: location,
                        initialBio: bio,
                        initialRole: role,
                        initialSkills: skills.join(', '),
                        initialGithub: github,
                        initialLinkedin: linkedin,
                        onSave: (n, l, b, r, s, g, li) {
                          // Profile updated via AuthProvider
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Iconsax.edit, size: 18),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  double _getCompletionPercentage(String name, String location, String bio, List<String> skills) {
    double c = 0.0;
    if (name.isNotEmpty) c += 0.2;
    if (location.isNotEmpty) c += 0.2;
    if (bio.isNotEmpty) c += 0.2;
    if (skills.isNotEmpty) c += 0.2;
    c += 0.2; // links always configured
    return c;
  }
}

class _LinkChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final ThemeData theme;

  const _LinkChip({
    required this.icon,
    required this.label,
    required this.url,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColor.primaryBlue),
            const SizedBox(width: 8),
            Text(label, style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }
}

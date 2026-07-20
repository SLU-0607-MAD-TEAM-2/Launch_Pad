import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'edit_profile_screen.dart';
import '../../widgets/scale_tap.dart';
import '../../utils/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _location = 'San Francisco, CA';
  String _bio =
      'Passionate UI/UX designer building beautiful developer tooling interfaces.';
  String _role = 'UI/UX Designer';
  String _github = 'https://github.com/johndoe';
  String _linkedin = 'https://linkedin.com/in/johndoe';

  final List<String> _skillsList = ['Dart', 'Flutter', 'Figma', 'Git'];
  final Set<String> _selectedSkills = {'Dart', 'Flutter'};

  double _getCompletionPercentage() {
    double c = 0.0;
    if (_name.isNotEmpty) c += 0.2;
    if (_location.isNotEmpty) c += 0.2;
    if (_bio.isNotEmpty) c += 0.2;
    if (_selectedSkills.isNotEmpty) c += 0.2;
    c += 0.2; // links always configured
    return c;
  }

  @override
  Widget build(BuildContext context) {
    final completionVal = _getCompletionPercentage();

    return Scaffold(
      backgroundColor: AppColor.screenBgLight,
      appBar: AppBar(
        backgroundColor: AppColor.screenBgLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Profile', style: AppTypography.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColor.borderHairline.withValues(alpha: 0.4),
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
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColor.white,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                      ),
                    ),
                  ),
                  // Camera badge
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColor.primaryBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.white, width: 2),
                      ),
                      child: const Icon(
                        Iconsax.camera,
                        size: 14,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Name ──────────────────────────────────────────────
            Center(
              child: Text(_name, style: AppTypography.displaySmall),
            ),
            const SizedBox(height: 6),

            // ── Location ─────────────────────────────────────────
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.location, size: 14, color: AppColor.mutedText),
                  const SizedBox(width: 4),
                  Text(_location,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColor.mutedText)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ── Role badge ───────────────────────────────────────
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColor.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppShapes.pillRadius),
                  border: Border.all(
                    color: AppColor.primaryBlue.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Iconsax.code, size: 13, color: AppColor.primaryBlue),
                    const SizedBox(width: 5),
                    Text(
                      _role,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColor.primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Bio ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _bio,
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColor.bodyText, height: 1.6),
              ),
            ),
            const SizedBox(height: 24),

            // ── Profile completion card ──────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(AppShapes.radiusXL),
                border: Border.all(
                    color: AppColor.borderHairline.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.headingDark.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.chart_2,
                              size: 15, color: AppColor.primaryBlue),
                          const SizedBox(width: 6),
                          Text('Profile Completion',
                              style: AppTypography.titleSmall.copyWith(
                                  color: AppColor.bodyText)),
                        ],
                      ),
                      Text(
                        '${(completionVal * 100).toInt()}% Complete',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: completionVal,
                      backgroundColor: AppColor.borderHairline,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.primaryBlue),
                      minHeight: 7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // ── Edit Profile button ──────────────────────────────
            Center(
              child: ScaleTap(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        initialName: _name,
                        initialLocation: _location,
                        initialBio: _bio,
                        initialRole: _role,
                        initialSkills: _selectedSkills.join(', '),
                        initialGithub: _github,
                        initialLinkedin: _linkedin,
                        onSave: (name, location, bio, role, skills, github,
                            linkedin) {
                          setState(() {
                            _name = name;
                            _location = location;
                            _bio = bio;
                            _role = role;
                            _github = github;
                            _linkedin = linkedin;
                            final parsed = skills
                                .split(',')
                                .map((s) => s.trim())
                                .where((s) => s.isNotEmpty)
                                .toList();
                            _selectedSkills.clear();
                            for (final s in parsed) {
                              _selectedSkills.add(s);
                              if (!_skillsList.contains(s)) _skillsList.add(s);
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile saved successfully!'),
                              backgroundColor: AppColor.success,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue.withValues(alpha: 0.07),
                    border: Border.all(
                        color: AppColor.primaryBlue.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(AppShapes.pillRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Iconsax.edit_2,
                          size: 15, color: AppColor.primaryBlue),
                      const SizedBox(width: 8),
                      Text(
                        'Edit Profile',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // ── Connect links ────────────────────────────────────
            _LinkTile(
              icon: Iconsax.code_1,
              label: 'GitHub Profile',
              iconColor: AppColor.headingDark,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening: $_github')),
              ),
            ),
            const SizedBox(height: 10),
            _LinkTile(
              icon: Iconsax.link_21,
              label: 'LinkedIn Profile',
              iconColor: AppColor.primaryBlue,
              labelColor: AppColor.primaryBlue,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening: $_linkedin')),
              ),
            ),
            const SizedBox(height: 32),

            // ── Technical Arsenal ────────────────────────────────
            Row(
              children: [
                const Icon(Iconsax.cpu, size: 18, color: AppColor.primaryBlue),
                const SizedBox(width: 8),
                Text('Technical Arsenal', style: AppTypography.headingSemiBold),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skillsList.map((skill) {
                final isSelected = _selectedSkills.contains(skill);
                return ScaleTap(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedSkills.remove(skill);
                      } else {
                        _selectedSkills.add(skill);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.primaryBlue
                          : AppColor.white,
                      borderRadius:
                          BorderRadius.circular(AppShapes.pillRadius),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.primaryBlue
                            : AppColor.borderHairline,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColor.primaryBlue
                                    .withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      skill,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected ? AppColor.white : AppColor.bodyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // ── My Applications ──────────────────────────────────
            Row(
              children: [
                const Icon(Iconsax.document_text,
                    size: 18, color: AppColor.primaryBlue),
                const SizedBox(width: 8),
                Text('My Applications', style: AppTypography.headingSemiBold),
              ],
            ),
            const SizedBox(height: 12),
            _buildApplicationCard('HEALTHAI', 'Pending', const Color(0xFFF59E0B)),
            const SizedBox(height: 8),
            _buildApplicationCard('FINFLOW', 'Accepted', AppColor.success),
            const SizedBox(height: 8),
            _buildApplicationCard(
                'SOLARIS PROTOCOL', 'Rejected', AppColor.error),
            const SizedBox(height: 32),

            // ── Saved Profiles ───────────────────────────────────
            Row(
              children: [
                const Icon(Iconsax.bookmark,
                    size: 18, color: AppColor.primaryBlue),
                const SizedBox(width: 8),
                Text('Saved Profiles', style: AppTypography.headingSemiBold),
              ],
            ),
            const SizedBox(height: 12),
            _buildSavedProfileCard(
              'Sarah Chen',
              'Flutter Developer',
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
            ),
            const SizedBox(height: 8),
            _buildSavedProfileCard(
              'Marcus Johnson',
              'Founder',
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
            ),
            const SizedBox(height: 8),
            _buildSavedProfileCard(
              'Emily Rodriguez',
              'UI/UX Designer',
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationCard(
      String projectName, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppShapes.radiusXL),
        border: Border.all(
            color: AppColor.borderHairline.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColor.headingDark.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  status == 'Accepted'
                      ? Iconsax.tick_circle
                      : status == 'Rejected'
                          ? Iconsax.close_circle
                          : Iconsax.clock,
                  size: 18,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(projectName, style: AppTypography.titleSmall),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppShapes.pillRadius),
            ),
            child: Text(
              status,
              style: AppTypography.caption.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedProfileCard(
      String name, String role, String avatarUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppShapes.radiusXL),
        border: Border.all(
            color: AppColor.borderHairline.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColor.headingDark.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: AppColor.skillBlueBg,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.titleSmall),
                const SizedBox(height: 2),
                Text(role,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColor.mutedText)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppShapes.pillRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.bookmark,
                    size: 12, color: AppColor.primaryBlue),
                const SizedBox(width: 4),
                Text(
                  'Saved',
                  style: AppTypography.caption.copyWith(
                    color: AppColor.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reusable link tile ──────────────────────────────────────────────────────

class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  const _LinkTile({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = labelColor ?? AppColor.headingDark;
    return ScaleTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(
              color: AppColor.borderHairline.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(AppShapes.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColor.headingDark.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.titleSmall.copyWith(color: color),
                ),
              ),
              Icon(Iconsax.arrow_right_3,
                  size: 16, color: AppColor.mutedText),
            ],
          ),
        ),
      ),
    );
  }
}

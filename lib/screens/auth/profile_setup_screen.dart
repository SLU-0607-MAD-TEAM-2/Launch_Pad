import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/app_input.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/skill_chip.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameCtrl = TextEditingController();
  final _headlineCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  Role _selectedRole = Role.developer;
  ExperienceLevel _level = ExperienceLevel.intermediate;
  final _selectedSkills = <String>[];

  static const _allSkills = [
    'Flutter', 'React', 'Python', 'Go', 'Swift',
    'Figma', 'UI/UX', 'Product Strategy', 'Fundraising',
    'AI/ML', 'Backend', 'DevOps', 'Marketing',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _headlineCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('Set up your profile', style: AppTypography.displaySmall),
              const SizedBox(height: 32),
              AppInput(label: 'Full Name', hint: 'Your name', controller: _nameCtrl),
              const SizedBox(height: 16),
              AppInput(label: 'Headline', hint: 'e.g. Full-stack dev', controller: _headlineCtrl),
              const SizedBox(height: 16),
              AppInput(label: 'Bio', hint: 'Tell people about yourself', controller: _bioCtrl, maxLines: 3),
              const SizedBox(height: 20),
              Text('I am a…', style: AppTypography.labelMedium),
              const SizedBox(height: 8),
              _roleSelector(),
              const SizedBox(height: 20),
              Text('Experience', style: AppTypography.labelMedium),
              const SizedBox(height: 8),
              _levelSelector(),
              const SizedBox(height: 20),
              Text('Skills (tap to select)', style: AppTypography.labelMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _allSkills.map((s) => SkillChip(
                  label: s,
                  selected: _selectedSkills.contains(s),
                  onTap: () {
                    setState(() {
                      if (_selectedSkills.contains(s)) {
                        _selectedSkills.remove(s);
                      } else {
                        _selectedSkills.add(s);
                      }
                    });
                  },
                )).toList(),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Complete Setup',
                isLoading: auth.isLoading,
                onPressed: () {
                  final updated = auth.currentUser!.copyWith(
                    name: _nameCtrl.text.trim().isEmpty ? auth.currentUser!.name : _nameCtrl.text.trim(),
                    headline: _headlineCtrl.text.trim().isEmpty ? null : _headlineCtrl.text.trim(),
                    bio: _bioCtrl.text.trim().isEmpty ? null : _bioCtrl.text.trim(),
                    role: _selectedRole,
                    experienceLevel: _level,
                    skills: _selectedSkills,
                    isLookingForTeam: true,
                  );
                  auth.updateProfile(updated);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleSelector() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Wrap(
      children: Role.values.map((r) {
      final selected = _selectedRole == r;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(r.name.capitalize()),
          selected: selected,
          onSelected: (_) => setState(() => _selectedRole = r),
          selectedColor: AppColor.primary.withValues(alpha: 0.15),
          backgroundColor: AppColor.surface.withValues(alpha: 0.5),
          side: BorderSide(color: selected ? AppColor.primary : AppColor.stroke),
        ),
      );
    }).toList(),),);

  Widget _levelSelector() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Wrap(
      children: ExperienceLevel.values.map((l) {
      final selected = _level == l;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(l.name.capitalize()),
          selected: selected,
          onSelected: (_) => setState(() => _level = l),
          selectedColor: AppColor.primary.withValues(alpha: 0.15),
          backgroundColor: AppColor.surface.withValues(alpha: 0.5),
          side: BorderSide(color: selected ? AppColor.primary : AppColor.stroke),
        ),
      );
    }).toList(),),);
}

extension on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

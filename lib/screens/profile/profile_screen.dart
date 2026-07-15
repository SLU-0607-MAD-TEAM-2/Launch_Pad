import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../../widgets/scale_tap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _location = 'San Francisco, CA';
  String _bio = 'Passionate UI/UX designer building beautiful developer tooling interfaces.';
  String _role = 'UI/UX Designer';
  String _github = 'https://github.com/johndoe';
  String _linkedin = 'https://linkedin.com/in/johndoe';

  final List<String> _skillsList = [
    'Dart',
    'Flutter',
    'Figma',
    'Git',
  ];

  final Set<String> _selectedSkills = {'Dart', 'Flutter'};

  // Calculate completion percentage:
  // Name (20%), Location (20%), Bio (20%), Skills selected (20%), Links (20%)
  double _getCompletionPercentage() {
    double completion = 0.0;
    if (_name.isNotEmpty && _name != 'John Doe') {
      completion += 0.2;
    } else if (_name == 'John Doe') {
      completion += 0.2; // default is filled
    }

    if (_location.isNotEmpty) completion += 0.2;
    if (_bio.isNotEmpty) completion += 0.2;
    if (_selectedSkills.isNotEmpty) completion += 0.2;
    
    // Default GitHub/LinkedIn links considered configured (20%)
    completion += 0.2;
    
    return completion;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completionVal = _getCompletionPercentage();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const SizedBox(height: 20),
            // Central Profile Avatar circle
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF0052FF), // Electric Blue
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Name label
            Center(
              child: Text(
                _name,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Location
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    _location,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Role Badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEDFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  _role,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF0052FF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                _bio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF475569),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Profile Completion Indicator
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile Completion',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF475569),
                        ),
                      ),
                      Text(
                        '${(completionVal * 100).toInt()}% Complete',
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF0052FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: completionVal,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0052FF)),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Edit Profile Button
            Center(
              child: ScaleTap(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening profile editor...'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
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
                         onSave: (name, location, bio, role, skills, github, linkedin) {
                           setState(() {
                             _name = name;
                             _location = location;
                             _bio = bio;
                             _role = role;
                             _github = github;
                             _linkedin = linkedin;
                             final parsedSkills = skills
                                 .split(',')
                                 .map((s) => s.trim())
                                 .where((s) => s.isNotEmpty)
                                 .toList();
                             _selectedSkills.clear();
                             for (final s in parsedSkills) {
                               _selectedSkills.add(s);
                               if (!_skillsList.contains(s)) {
                                 _skillsList.add(s);
                               }
                             }
                           });
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                               content: Text('Profile saved successfully!'),
                               backgroundColor: Colors.green,
                               duration: Duration(seconds: 2),
                             ),
                           );
                         },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF0052FF)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: 16, color: Color(0xFF0052FF)),
                      SizedBox(width: 8),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0052FF),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            // Bordered 'GitHub' and 'LinkedIn' rows
            // GitHub profile link tile
            ScaleTap(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Redirecting to GitHub: $_github')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const ListTile(
                  leading: Icon(Icons.code_rounded, color: Color(0xFF0F172A), size: 22),
                  title: Text(
                    'GitHub Profile',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // LinkedIn profile link tile
            ScaleTap(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Redirecting to LinkedIn: $_linkedin')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const ListTile(
                  leading: Icon(Icons.link_rounded, color: Color(0xFF0052FF), size: 22),
                  title: Text(
                    'LinkedIn Profile',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0052FF),
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 'Technical Arsenal' Section
            const Text(
              'Technical Arsenal',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 16),
            // Wrap layout with custom tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skillsList.map((skill) {
                final isSelected = _selectedSkills.contains(skill);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedSkills.remove(skill);
                      } else {
                        _selectedSkills.add(skill);
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isSelected ? 'Removed $skill from skills' : 'Added $skill to skills'),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0052FF) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0052FF) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

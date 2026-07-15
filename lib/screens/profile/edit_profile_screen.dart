import 'package:flutter/material.dart';
import '../../widgets/scale_tap.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialLocation;
  final String initialBio;
  final String initialRole;
  final String initialSkills;
  final String initialGithub;
  final String initialLinkedin;
  final Function(
    String name,
    String location,
    String bio,
    String role,
    String skills,
    String github,
    String linkedin,
  ) onSave;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialLocation,
    required this.initialBio,
    required this.initialRole,
    required this.initialSkills,
    required this.initialGithub,
    required this.initialLinkedin,
    required this.onSave,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _bioController;
  late final TextEditingController _roleController;
  late final TextEditingController _skillsController;
  late final TextEditingController _githubController;
  late final TextEditingController _linkedinController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _locationController = TextEditingController(text: widget.initialLocation);
    _bioController = TextEditingController(text: widget.initialBio);
    _roleController = TextEditingController(text: widget.initialRole);
    _skillsController = TextEditingController(text: widget.initialSkills);
    _githubController = TextEditingController(text: widget.initialGithub);
    _linkedinController = TextEditingController(text: widget.initialLinkedin);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    _roleController.dispose();
    _skillsController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  void _showPhotoSourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Color(0xFF0052FF)),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(bc);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Camera simulated successfully.')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF0052FF)),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(bc);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gallery simulated successfully.')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        _nameController.text.trim(),
        _locationController.text.trim(),
        _bioController.text.trim(),
        _roleController.text.trim(),
        _skillsController.text.trim(),
        _githubController.text.trim(),
        _linkedinController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      floatingLabelStyle: const TextStyle(color: Color(0xFF0052FF), fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0052FF), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isLargeScreen = mediaQuery.size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 18,
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? (mediaQuery.size.width - 500) / 2 : 20.0,
                  vertical: 24.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Upload Section
                      Center(
                        child: GestureDetector(
                          onTap: () => _showPhotoSourceSheet(context),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundImage: const NetworkImage(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                                ),
                                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Color(0xFF0052FF),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Section Title
                      const Text(
                        'PROFILE DETAILS',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('Full Name', 'John Doe'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Role
                      TextFormField(
                        controller: _roleController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('Professional Role', 'e.g. UI/UX Designer'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your professional role'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Location
                      TextFormField(
                        controller: _locationController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('Location', 'e.g. San Francisco, CA'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your location'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Bio
                      TextFormField(
                        controller: _bioController,
                        maxLines: 4,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('Short Bio', 'Tell us about yourself...'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please write a short bio'
                            : null,
                      ),
                      const SizedBox(height: 32),

                      // Section Title: Skills & Social
                      const Text(
                        'SKILLS & LINKS',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Skills (comma-separated)
                      TextFormField(
                        controller: _skillsController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration(
                          'Technical Skills',
                          'e.g. Flutter, Figma, Dart (comma-separated)',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // GitHub Profile Link
                      TextFormField(
                        controller: _githubController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('GitHub URL', 'https://github.com/username'),
                      ),
                      const SizedBox(height: 20),

                      // LinkedIn Profile Link
                      TextFormField(
                        controller: _linkedinController,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF0F172A)),
                        decoration: _buildInputDecoration('LinkedIn URL', 'https://linkedin.com/in/username'),
                      ),
                      const SizedBox(height: 36),

                      // Responsive Cancel and Save Buttons Row with ScaleTap animations
                      Row(
                        children: [
                          Expanded(
                            child: ScaleTap(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Changes discarded.'),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: 'Geist',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ScaleTap(
                              onTap: _saveProfile,
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0052FF),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0052FF).withValues(alpha: 0.2),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Save Changes',
                                    style: TextStyle(
                                      fontFamily: 'Geist',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

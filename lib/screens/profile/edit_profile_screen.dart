import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../providers/auth_provider.dart';
import '../../services/firebase_data_service.dart';
import '../../utils/app_theme.dart';
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
  final _firebaseService = FirebaseDataService();
  final _imagePicker = ImagePicker();

  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _bioController;
  late final TextEditingController _roleController;
  late final TextEditingController _skillsController;
  late final TextEditingController _githubController;
  late final TextEditingController _linkedinController;

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;
  String? _currentAvatarUrl;
  bool _isUploading = false;

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

    // Load current user's avatar URL
    _loadCurrentAvatar();
  }

  void _loadCurrentAvatar() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Try to get avatar from auth provider
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authProvider = context.read<AuthProvider>();
        if (authProvider.currentUser?.avatarUrl.isNotEmpty == true) {
          setState(() {
            _currentAvatarUrl = authProvider.currentUser!.avatarUrl;
          });
        }
      });
    }
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
                onTap: () async {
                  Navigator.pop(bc);
                  final image = await _imagePicker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 512,
                    maxHeight: 512,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    setState(() {
                      _selectedImage = image;
                      _selectedImageBytes = bytes;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF0052FF)),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(bc);
                  final image = await _imagePicker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 512,
                    maxHeight: 512,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    setState(() {
                      _selectedImage = image;
                      _selectedImageBytes = bytes;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUploading = true);

    // Upload avatar if selected
    String? avatarUrl = _currentAvatarUrl;
    if (_selectedImage != null) {
      avatarUrl = await _firebaseService.uploadAvatarFromXFile(_selectedImage!);
    }

    // Update auth provider with new avatar
    if (avatarUrl != null && mounted) {
      final auth = context.read<AuthProvider>();
      if (auth.currentUser != null) {
        await auth.updateProfile(auth.currentUser!.copyWith(avatarUrl: avatarUrl));
      }
    }

    widget.onSave(
      _nameController.text.trim(),
      _locationController.text.trim(),
      _bioController.text.trim(),
      _roleController.text.trim(),
      _skillsController.text.trim(),
      _githubController.text.trim(),
      _linkedinController.text.trim(),
    );

    setState(() => _isUploading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }

  InputDecoration _buildInputDecoration(ThemeData theme, String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14),
      hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
      floatingLabelStyle: const TextStyle(color: AppColor.primaryBlue, fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: theme.colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.15)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primaryBlue, width: 1.5),
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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: theme.textTheme.titleMedium?.copyWith(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
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
                                backgroundImage: _selectedImageBytes != null
                                    ? MemoryImage(_selectedImageBytes!) as ImageProvider
                                    : (_currentAvatarUrl?.isNotEmpty == true
                                        ? NetworkImage(_currentAvatarUrl!) as ImageProvider
                                        : const NetworkImage(
                                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                                          ) as ImageProvider),
                                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                              ),
                              if (_isUploading)
                                const Positioned.fill(
                                  child: CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Colors.black38,
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
                      Text(
                        'PROFILE DETAILS',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'Full Name', 'John Doe'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Role
                      TextFormField(
                        controller: _roleController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'Professional Role', 'e.g. UI/UX Designer'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your professional role'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Location
                      TextFormField(
                        controller: _locationController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'Location', 'e.g. San Francisco, CA'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please enter your location'
                            : null,
                      ),
                      const SizedBox(height: 20),

                      // Bio
                      TextFormField(
                        controller: _bioController,
                        maxLines: 4,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'Short Bio', 'Tell us about yourself...'),
                        validator: (value) => value == null || value.trim().isEmpty
                            ? 'Please write a short bio'
                            : null,
                      ),
                      const SizedBox(height: 32),

                      // Section Title: Skills & Social
                      Text(
                        'SKILLS & LINKS',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Skills (comma-separated)
                      TextFormField(
                        controller: _skillsController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(
                          theme,
                          'Technical Skills',
                          'e.g. Flutter, Figma, Dart (comma-separated)',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // GitHub Profile Link
                      TextFormField(
                        controller: _githubController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'GitHub URL', 'https://github.com/username'),
                      ),
                      const SizedBox(height: 20),

                      // LinkedIn Profile Link
                      TextFormField(
                        controller: _linkedinController,
                        style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface),
                        decoration: _buildInputDecoration(theme, 'LinkedIn URL', 'https://linkedin.com/in/username'),
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

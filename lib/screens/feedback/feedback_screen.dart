import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/app_theme.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentsController = TextEditingController();
  String? _selectedCategory;
  int _rating = 0;

  final List<String> _categories = [
    'Bug Report',
    'Feature Request',
    'General Feedback',
    'UI/UX Issue',
    'Performance',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.close_circle, color: theme.colorScheme.onSurface, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Send Feedback', style: theme.textTheme.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: theme.colorScheme.onSurface.withValues(alpha: 0.08), height: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section: Your Information ──────────────────────
                _sectionLabel('YOUR INFORMATION', theme),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _nameController,
                  style: theme.textTheme.bodyMedium,
                  decoration: _inputDecoration(theme, 'Full Name', 'John Doe', prefixIcon: Iconsax.user),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: theme.textTheme.bodyMedium,
                  decoration: _inputDecoration(theme, 'Email', 'you@example.com', prefixIcon: Iconsax.sms),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // ── Section: Feedback Details ──────────────────────
                _sectionLabel('FEEDBACK DETAILS', theme),
                const SizedBox(height: 14),

                Text('Category', style: theme.textTheme.labelLarge),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: _inputDecoration(theme, '', 'Select a category'),
                  icon: Icon(Iconsax.arrow_down, size: 16, color: theme.colorScheme.onSurfaceVariant),
                  dropdownColor: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat, style: theme.textTheme.bodySmall),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please select a category' : null,
                ),
                const SizedBox(height: 24),

                // ── Star Rating ────────────────────────────────────
                Row(
                  children: List.generate(5, (index) {
                    final starNum = index + 1;
                    return GestureDetector(
                      onTap: () => setState(() => _rating = starNum),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          starNum <= _rating ? Iconsax.star_15 : Iconsax.star,
                          size: 32,
                          color: starNum <= _rating
                              ? const Color(0xFFF59E0B)
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }),
                ),
                if (_rating > 0) ...[
                  const SizedBox(height: 6),
                  Text(
                    _ratingLabel(_rating),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFF59E0B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // ── Comments ───────────────────────────────────────
                Text('Comments', style: theme.textTheme.labelLarge),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _commentsController,
                  maxLines: 5,
                  style: theme.textTheme.bodySmall,
                  decoration: _inputDecoration(
                    theme,
                    '',
                    'Tell us what you think, or describe any issues...',
                  ).copyWith(alignLabelWithHint: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Please enter your feedback';
                    if (v.trim().length < 10) return 'Provide at least 10 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 36),

                // ── Submit ─────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    icon: const Icon(Iconsax.send_1, size: 18),
                    label: Text(
                      'Submit Feedback',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryBlue,
                      foregroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text, ThemeData theme) => Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 1.4,
          fontWeight: FontWeight.w600,
        ),
      );

  InputDecoration _inputDecoration(ThemeData theme, String label, String hint, {IconData? prefixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 18, color: theme.colorScheme.onSurfaceVariant)
          : null,
      labelStyle: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      hintStyle: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
      floatingLabelStyle: theme.textTheme.labelSmall?.copyWith(
        color: AppColor.primaryBlue,
        fontWeight: FontWeight.w700,
      ),
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
        borderSide: const BorderSide(color: AppColor.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.error, width: 1.5),
      ),
    );
  }

  String _ratingLabel(int r) {
    const labels = ['Terrible', 'Poor', 'Okay', 'Good', 'Excellent!'];
    return labels[r - 1];
  }
}

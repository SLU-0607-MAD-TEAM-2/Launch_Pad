import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _ratingError = false;

  final List<String> _categories = [
    'Bug Report',
    'Feature Request',
    'General Feedback',
    'Usability Issue',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    setState(() => _ratingError = _rating == 0);
    if (_formKey.currentState!.validate() && _rating > 0) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColor.success,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            duration: const Duration(seconds: 3),
            content: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.white, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Feedback received!',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Thank you for helping us improve LaunchPad.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label, String hint, {IconData? prefixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, size: 18, color: AppColor.mutedText)
          : null,
      labelStyle: AppTypography.bodySmall.copyWith(color: AppColor.mutedText),
      hintStyle: AppTypography.bodySmall.copyWith(color: AppColor.placeholderText),
      floatingLabelStyle: AppTypography.labelSmall.copyWith(
        color: AppColor.primaryBlue,
        fontWeight: FontWeight.w700,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: AppColor.inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.borderHairline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.borderHairline),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgLight,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle, color: AppColor.headingDark, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Send Feedback', style: AppTypography.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColor.borderHairline, height: 1),
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
                _sectionLabel('YOUR INFORMATION'),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _nameController,
                  style: AppTypography.bodyMedium,
                  decoration: _inputDecoration('Full Name', 'John Doe', prefixIcon: Iconsax.user),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTypography.bodyMedium,
                  decoration: _inputDecoration('Email', 'you@example.com', prefixIcon: Iconsax.sms),
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
                _sectionLabel('FEEDBACK DETAILS'),
                const SizedBox(height: 14),

                Text('Category', style: AppTypography.labelLarge),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: _inputDecoration('', 'Select a category'),
                  icon: const Icon(Iconsax.arrow_down, size: 16, color: AppColor.mutedText),
                  dropdownColor: AppColor.white,
                  borderRadius: BorderRadius.circular(14),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat, style: AppTypography.bodySmall),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please select a category' : null,
                ),
                const SizedBox(height: 24),

                // ── Star Rating ────────────────────────────────────
                Row(
                  children: [
                    Text('Rating', style: AppTypography.labelLarge),
                    if (_rating > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        _ratingLabel(_rating),
                        style: AppTypography.caption.copyWith(
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (i) {
                    final filled = i < _rating;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _rating = i + 1;
                          _ratingError = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOutBack,
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          filled ? Iconsax.star5 : Iconsax.star,
                          color: filled ? const Color(0xFFFFB800) : AppColor.borderHairline,
                          size: filled ? 38 : 34,
                        ),
                      ),
                    );
                  }),
                ),
                if (_ratingError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      'Please select a rating',
                      style: AppTypography.caption.copyWith(color: AppColor.error),
                    ),
                  ),
                const SizedBox(height: 24),

                Text('Comments', style: AppTypography.labelLarge),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _commentsController,
                  maxLines: 5,
                  style: AppTypography.bodySmall,
                  decoration: _inputDecoration(
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
                      style: AppTypography.labelLarge.copyWith(
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
                      shadowColor: AppColor.primaryBlue.withValues(alpha: 0.3),
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

  Widget _sectionLabel(String text) => Text(
        text,
        style: AppTypography.captionUppercase.copyWith(
          color: AppColor.mutedText,
          letterSpacing: 1.4,
        ),
      );

  String _ratingLabel(int r) {
    const labels = ['Terrible', 'Poor', 'Okay', 'Good', 'Excellent!'];
    return labels[r - 1];
  }
}

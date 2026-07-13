import 'package:flutter/material.dart';

class DesignColors {
  static const Color primary = Color(0xFF003EC7);
  static const Color secondary = Color(0xFF006875);
  static const Color secondaryContainer = Color(0xFF00E3FD);
  static const Color tertiary = Color(0xFF853600);
  static const Color background = Color(0xFFFAF8FF);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color border = Color(0xFFE5E7EB);
  static const Color lightGray = Color(0xFFF3F4F6);

  static const Map<String, Color> roleColors = {
    'founder': Color(0xFF003EC7),
    'developer': Color(0xFF006875),
    'creative': Color(0xFF853600),
    'marketer': Color(0xFF7C3AED),
    'operator': Color(0xFF0891B2),
  };

  static const Map<String, Color> roleGradients = {
    'founder': Color(0xFF0028A0),
    'developer': Color(0xFF005A64),
    'creative': Color(0xFF7A2E00),
    'marketer': Color(0xFF6D28D9),
    'operator': Color(0xFF067A8F),
  };

  static const Map<String, IconData> roleIcons = {
    'founder': Icons.lightbulb_outline,
    'developer': Icons.code,
    'creative': Icons.palette_outlined,
    'marketer': Icons.trending_up,
    'operator': Icons.settings_outlined,
  };

  static const Map<String, String> roleLabels = {
    'founder': 'Founder',
    'developer': 'Developer',
    'creative': 'Creative',
    'marketer': 'Marketer',
    'operator': 'Operator',
  };

  static const Map<String, String> roleSubtitles = {
    'founder': 'Vision & Strategy',
    'developer': 'Build & Engineer',
    'creative': 'Design & Brand',
    'marketer': 'Growth & Reach',
    'operator': 'Manage & Scale',
  };

  static const Map<String, Color> stageColors = {
    'idea': Color(0xFF8B5CF6),
    'prototype': Color(0xFFF59E0B),
    'mvp': Color(0xFF3B82F6),
    'growth': Color(0xFF10B981),
  };

  static const Map<String, String> stageLabels = {
    'idea': 'Idea',
    'prototype': 'Prototype',
    'mvp': 'MVP',
    'growth': 'Growth',
  };

  static const Map<String, Color> statusColors = {
    'pending': Color(0xFFF59E0B),
    'accepted': Color(0xFF10B981),
    'rejected': Color(0xFFEF4444),
  };
}

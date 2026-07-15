import 'enums.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final Role role;
  final String headline;
  final String bio;
  final List<String> skills;
  final ExperienceLevel experienceLevel;
  final List<String> interests;
  final String location;
  final bool isLookingForTeam;
  final String avatarUrl;
  final String? githubUrl;
  final String? linkedInUrl;
  final bool isVerified;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.headline = '',
    this.bio = '',
    this.skills = const [],
    this.experienceLevel = ExperienceLevel.entry,
    this.interests = const [],
    this.location = '',
    this.isLookingForTeam = false,
    this.avatarUrl = '',
    this.githubUrl,
    this.linkedInUrl,
    this.isVerified = false,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: roleFromString(json['role'] as String) ?? Role.founder,
      headline: json['headline'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      skills: (json['skills'] as List<dynamic>?)?.cast<String>() ?? [],
      experienceLevel: levelFromString(json['experienceLevel'] as String? ?? ''),
      interests: (json['interests'] as List<dynamic>?)?.cast<String>() ?? [],
      location: json['location'] as String? ?? '',
      isLookingForTeam: json['isLookingForTeam'] as bool? ?? false,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      githubUrl: json['githubUrl'] as String?,
      linkedInUrl: json['linkedInUrl'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'headline': headline,
      'bio': bio,
      'skills': skills,
      'experienceLevel': experienceLevel.name,
      'interests': interests,
      'location': location,
      'isLookingForTeam': isLookingForTeam,
      'avatarUrl': avatarUrl,
      'githubUrl': githubUrl,
      'linkedInUrl': linkedInUrl,
      'isVerified': isVerified,
    };
  }

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
    String? headline,
    String? bio,
    List<String>? skills,
    ExperienceLevel? experienceLevel,
    List<String>? interests,
    String? location,
    bool? isLookingForTeam,
    String? avatarUrl,
    String? githubUrl,
    String? linkedInUrl,
    bool? isVerified,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      headline: headline ?? this.headline,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      interests: interests ?? this.interests,
      location: location ?? this.location,
      isLookingForTeam: isLookingForTeam ?? this.isLookingForTeam,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

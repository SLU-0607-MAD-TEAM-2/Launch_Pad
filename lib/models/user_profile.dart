import 'enums.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final Role role;
  final String? headline;
  final String? bio;
  final String? photoUrl;
  final String? portfolioUrl;
  final String? githubUrl;
  final String? linkedInUrl;
  final List<String> skills;
  final ExperienceLevel experienceLevel;
  final List<String> interests;
  final String? location;
  final bool isLookingForTeam;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.headline,
    this.bio,
    this.photoUrl,
    this.portfolioUrl,
    this.githubUrl,
    this.linkedInUrl,
    this.skills = const [],
    this.experienceLevel = ExperienceLevel.entry,
    this.interests = const [],
    this.location,
    this.isLookingForTeam = true,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
    String? headline,
    String? bio,
    String? photoUrl,
    String? portfolioUrl,
    String? githubUrl,
    String? linkedInUrl,
    List<String>? skills,
    ExperienceLevel? experienceLevel,
    List<String>? interests,
    String? location,
    bool? isLookingForTeam,
  }) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        headline: headline ?? this.headline,
        bio: bio ?? this.bio,
        photoUrl: photoUrl ?? this.photoUrl,
        portfolioUrl: portfolioUrl ?? this.portfolioUrl,
        githubUrl: githubUrl ?? this.githubUrl,
        linkedInUrl: linkedInUrl ?? this.linkedInUrl,
        skills: skills ?? this.skills,
        experienceLevel: experienceLevel ?? this.experienceLevel,
        interests: interests ?? this.interests,
        location: location ?? this.location,
        isLookingForTeam: isLookingForTeam ?? this.isLookingForTeam,
      );
}

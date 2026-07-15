/// Model representing a LaunchPad user profile.
class UserProfile {
  final String id;
  final String name;
  final String location;
  final String bio;
  final String role;
  final String avatarUrl;
  final List<String> skills;
  final String? githubUrl;
  final String? linkedInUrl;
  final bool isVerified;

  const UserProfile({
    required this.id,
    required this.name,
    required this.location,
    required this.bio,
    required this.role,
    required this.avatarUrl,
    required this.skills,
    this.githubUrl,
    this.linkedInUrl,
    this.isVerified = false,
  });

  UserProfile copyWith({
    String? name,
    String? location,
    String? bio,
    String? role,
    String? avatarUrl,
    List<String>? skills,
    String? githubUrl,
    String? linkedInUrl,
    bool? isVerified,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      skills: skills ?? this.skills,
      githubUrl: githubUrl ?? this.githubUrl,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

/// Mock data: a deck of profiles to swipe through.
const List<UserProfile> mockSwipeProfiles = [
  UserProfile(
    id: 'alex_01',
    name: 'Alex Rivera',
    location: 'San Francisco, CA',
    bio: 'Passionate about bridging the gap between clinical efficiency and vibrant consumer experiences. Building the next gen of SaaS.',
    role: 'UI/UX Designer & Prototyper',
    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB4skV-RUHrptUgB-jYVUXr7eBX_tsRh-jjIoGY4mctFCwhDyEsnOQGpkoqTv_-5P4-9ZKIthgTkcJ972ZK5tYxlGByLtxC_IyEDiESep-Rc0tS03IS9dYB3QpmugAu_TydUxuN5V0cELWm3sDzngqBLCEaZN2-xpgSDt5JtpfcAz1bYdbl_Oh6fD9wzNkCNTXWJEmPPdkHkRPghWfhKHItZiHCuw4s2OkopdEKKUnTLYb6qZoqwZT6',
    skills: ['Figma', 'React Native', 'Design Systems'],
    isVerified: true,
  ),
  UserProfile(
    id: 'jordan_02',
    name: 'Jordan Miller',
    location: 'New York, NY',
    bio: 'Full-stack developer with 5 years experience. I love clean architecture and performance-first engineering for mobile apps.',
    role: 'Technical Lead',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    skills: ['Flutter', 'Node.js', 'PostgreSQL'],
    isVerified: true,
  ),
  UserProfile(
    id: 'sarah_03',
    name: 'Sarah Jenkins',
    location: 'Austin, TX',
    bio: 'Serial entrepreneur with two successful exits. I bring deep domain expertise in HealthTech and loves a good pivot.',
    role: 'Technical Co-Founder',
    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAFh5trnSnCFje0UizScieerRck6hzY-r1PDGtKoytA-N9v15OiocuwHxhPXt4Q0VSzq5k8eNUxB1E6v5tcFh5RhnqevKQFwMzSldymAignJk6vtB7O0hpZI8tQ6F6zh0RaVI-ZNy4QS3N46o2eUcgwzmf5_Y4i7svkGQ1qKBb9xtXbe-9l_0ZPWyicshcA_3ssArnW5HftQM-OLUNCOuf3an2paWe9PtStJLqRolwKoCihXRBuPLDS',
    skills: ['Python', 'TensorFlow', 'HealthTech'],
    isVerified: false,
  ),
  UserProfile(
    id: 'david_04',
    name: 'David Chen',
    location: 'Seattle, WA',
    bio: 'Product thinker turned builder. I obsess over user journeys, conversion funnels and data-driven growth loops.',
    role: 'Product Lead',
    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVTNE7i1d7R63TidA_TGD1Xsv7J-bN4fDDPZGNsVLjNrO1wYb83Ru0NlaOaq50GEv2Wo_yXfrjWK5zaorgscL4Cogfn316DtwWb3qQvUUw-ApbOL35DHpVPcdscqdUbembaru4tsNScdoPlUELHsoAMlcVwosltBSyrSU2jjiSwkdCKuSXV3f_Cb0rRi-b2b4BKiKZ4kUxxCPyBZU3vNO4_3-kn2N-P6CzbThAWTP5zYdYceNzuJWm',
    skills: ['Product Strategy', 'Analytics', 'Growth'],
    isVerified: false,
  ),
];

import '../models/user_profile.dart';
import '../models/match_model.dart';
import '../models/message.dart';
import '../models/enums.dart';

class SampleData {
  SampleData._();

  static final profiles = [
    UserProfile(
      id: 'p1',
      name: 'Sarah Chen',
      email: 'sarah@example.com',
      role: Role.developer,
      headline: 'Full‑stack dev & AI tinkerer',
      bio: 'Building cool stuff with Flutter + Firebase. Love hackathons and open source.',
      skills: ['Flutter', 'Firebase', 'Python', 'Docker', 'GraphQL'],
      experienceLevel: ExperienceLevel.intermediate,
      interests: ['AI/ML', 'Mobile', 'Open Source'],
      location: 'New York, NY',
    ),
    UserProfile(
      id: 'p2',
      name: 'Marcus Johnson',
      email: 'marcus@example.com',
      role: Role.founder,
      headline: 'Seed‑stage founder, marketplace space',
      bio: 'Second‑time founder. Raised \$1.2M pre‑seed. Looking for a technical co‑founder.',
      skills: ['Product Strategy', 'Fundraising', 'Growth Marketing', 'Swift'],
      experienceLevel: ExperienceLevel.senior,
      interests: ['Marketplaces', 'SaaS', 'Fintech'],
      location: 'Austin, TX',
    ),
    UserProfile(
      id: 'p3',
      name: 'Emily Rodriguez',
      email: 'emily@example.com',
      role: Role.designer,
      headline: 'Product designer who codes',
      bio: 'Figma → Flutter pipeline enthusiast. 5 years designing B2B SaaS products.',
      skills: ['Figma', 'UI/UX', 'Flutter', 'Design Systems', 'Prototyping'],
      experienceLevel: ExperienceLevel.senior,
      interests: ['SaaS', 'Developer Tools', 'Design Systems'],
      location: 'Remote',
    ),
    UserProfile(
      id: 'p4',
      name: 'David Park',
      email: 'david@example.com',
      role: Role.creative,
      headline: 'Video editor + motion designer',
      bio: 'Creating viral content for tech startups. After Effects wizard.',
      skills: ['After Effects', 'Premiere Pro', 'Blender', 'DaVinci Resolve'],
      experienceLevel: ExperienceLevel.intermediate,
      interests: ['Content Creation', 'Animation', 'Gaming'],
      location: 'Los Angeles, CA',
    ),
    UserProfile(
      id: 'p5',
      name: 'Aisha Patel',
      email: 'aisha@example.com',
      role: Role.developer,
      headline: 'Backend eng turned indie hacker',
      bio: 'Go + Rust enthusiast. Building developer tools in public.',
      skills: ['Go', 'Rust', 'PostgreSQL', 'Kubernetes', 'Redis'],
      experienceLevel: ExperienceLevel.senior,
      interests: ['Developer Tools', 'DevOps', 'Infrastructure'],
      location: 'Seattle, WA',
    ),
    UserProfile(
      id: 'p6',
      name: 'James Wilson',
      email: 'james@example.com',
      role: Role.founder,
      headline: 'Climate tech founder',
      bio: 'MIT grad. Working on carbon capture monitoring. Need a hardware&#x2B;software engineer.',
      skills: ['Hardware', 'IoT', 'Python', 'Business Development'],
      experienceLevel: ExperienceLevel.lead,
      interests: ['Climate Tech', 'Hardware', 'Sustainability'],
      location: 'Boston, MA',
    ),
  ];

  static final matches = [
    MatchModel(
      id: 'm1',
      userId: 'current_user',
      matchedUserId: 'p1',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isMutual: true,
    ),
    MatchModel(
      id: 'm2',
      userId: 'current_user',
      matchedUserId: 'p3',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isMutual: true,
    ),
    MatchModel(
      id: 'm3',
      userId: 'current_user',
      matchedUserId: 'p5',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isMutual: true,
    ),
  ];

  static final Map<String, List<Message>> conversations = {
    'p1': [
      Message(
        id: 'msg1',
        senderId: 'p1',
        receiverId: 'current_user',
        content: 'Hey! I saw your profile — love that you\'re building with Flutter!',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
      ),
      Message(
        id: 'msg2',
        senderId: 'current_user',
        receiverId: 'p1',
        content: 'Thanks Sarah! Your AI projects look amazing. Would love to chat about potential collab.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 50)),
        isRead: true,
      ),
      Message(
        id: 'msg3',
        senderId: 'p1',
        receiverId: 'current_user',
        content: 'Absolutely! I\'m working on an AI-powered code review tool. Would love your input!',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
        isRead: true,
      ),
      Message(
        id: 'msg4',
        senderId: 'p1',
        receiverId: 'current_user',
        content: 'Are you free for a quick call this weekend?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 44)),
        isRead: false,
      ),
    ],
    'p3': [
      Message(
        id: 'msg5',
        senderId: 'p3',
        receiverId: 'current_user',
        content: 'Love your product sense! Would you be open to reviewing my portfolio?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      Message(
        id: 'msg6',
        senderId: 'current_user',
        receiverId: 'p3',
        content: 'Of course! Your design system work is impressive. Happy to swap feedback.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: -15)),
        isRead: true,
      ),
    ],
    'p5': [
      Message(
        id: 'msg7',
        senderId: 'current_user',
        receiverId: 'p5',
        content: 'Hey Aisha! Your Go projects are fire. Any interest in collaborating on a dev tool?',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      Message(
        id: 'msg8',
        senderId: 'p5',
        receiverId: 'current_user',
        content: 'Hey thanks! Always open to collab. What did you have in mind?',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: -30)),
        isRead: true,
      ),
    ],
  };
}

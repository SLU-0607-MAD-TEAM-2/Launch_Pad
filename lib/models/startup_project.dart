class StartupProject {
  final String id;
  final String title;
  final String description;
  final String founderId;
  final String founderName;
  final String founderAvatar;
  final List<String> rolesNeeded;
  final List<String> skillsRequired;
  final String stage;
  final String industry;
  final String location;
  final String coverUrl;
  final bool isRemote;
  final DateTime createdAt;

  StartupProject({
    required this.id,
    required this.title,
    required this.description,
    required this.founderId,
    this.founderName = '',
    this.founderAvatar = '',
    this.rolesNeeded = const [],
    this.skillsRequired = const [],
    this.stage = 'idea',
    this.industry = '',
    this.location = '',
    this.coverUrl = '',
    this.isRemote = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StartupProject.fromJson(Map<String, dynamic> json) {
    return StartupProject(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      founderId: json['founderId'] as String,
      founderName: json['founderName'] as String? ?? '',
      founderAvatar: json['founderAvatar'] as String? ?? '',
      rolesNeeded: List<String>.from(json['rolesNeeded'] as List? ?? []),
      skillsRequired: List<String>.from(json['skillsRequired'] as List? ?? []),
      stage: json['stage'] as String? ?? 'idea',
      industry: json['industry'] as String? ?? '',
      location: json['location'] as String? ?? '',
      coverUrl: json['coverUrl'] as String? ?? '',
      isRemote: json['isRemote'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'founderId': founderId,
      'founderName': founderName,
      'founderAvatar': founderAvatar,
      'rolesNeeded': rolesNeeded,
      'skillsRequired': skillsRequired,
      'stage': stage,
      'industry': industry,
      'location': location,
      'coverUrl': coverUrl,
      'isRemote': isRemote,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<StartupProject> sampleProjects() {
    return [
      StartupProject(
        id: 'p1',
        title: 'LearnAI',
        description: 'AI-powered personalized learning platform that adapts to each student\'s pace and style. We\'re building the future of education with adaptive algorithms and interactive content.',
        founderId: 'u1',
        founderName: 'Alex Rivera',
        founderAvatar: '',
        rolesNeeded: ['Developer', 'Creative'],
        skillsRequired: ['Flutter', 'Python', 'UI Design', 'Content'],
        stage: 'idea',
        industry: 'EdTech',
        location: 'San Francisco, CA',
        isRemote: true,
      ),
      StartupProject(
        id: 'p2',
        title: 'GreenRoute',
        description: 'Last-mile delivery optimization platform using ML to reduce carbon emissions. Help us make logistics sustainable.',
        founderId: 'u4',
        founderName: 'Priya Patel',
        founderAvatar: '',
        rolesNeeded: ['Developer', 'Creative'],
        skillsRequired: ['React', 'Python', 'UI/UX', 'Data Science'],
        stage: 'prototype',
        industry: 'Climate Tech',
        location: 'Miami, FL',
        isRemote: true,
      ),
      StartupProject(
        id: 'p3',
        title: 'CollabFlow',
        description: 'All-in-one collaboration hub for distributed teams. Integrates project management, docs, and real-time communication.',
        founderId: 'u9',
        founderName: 'Ryan Nguyen',
        founderAvatar: '',
        rolesNeeded: ['Developer'],
        skillsRequired: ['Flutter', 'Node.js', 'WebSocket', 'PostgreSQL'],
        stage: 'idea',
        industry: 'Productivity',
        location: 'Denver, CO',
        isRemote: true,
      ),
      StartupProject(
        id: 'p4',
        title: 'HealthPulse',
        description: 'Wearable health analytics platform that provides real-time insights and early detection for preventive healthcare.',
        founderId: 'u1',
        founderName: 'Alex Rivera',
        founderAvatar: '',
        rolesNeeded: ['Developer', 'Creative'],
        skillsRequired: ['Flutter', 'TensorFlow', 'UI/UX', 'IoT'],
        stage: 'mvp',
        industry: 'HealthTech',
        location: 'San Francisco, CA',
        isRemote: false,
      ),
      StartupProject(
        id: 'p5',
        title: 'ArtBlock',
        description: 'NFT marketplace for digital artists with built-in collaboration tools and fair royalty distribution.',
        founderId: 'u4',
        founderName: 'Priya Patel',
        founderAvatar: '',
        rolesNeeded: ['Developer', 'Creative'],
        skillsRequired: ['Solidity', 'React', 'Illustration', 'Branding'],
        stage: 'idea',
        industry: 'Web3',
        location: 'Miami, FL',
        isRemote: true,
      ),
    ];
  }
}

class StartupProject {
  final String id;
  final String name;
  final String snippet;
  final String description;
  final String domain;
  final String founderId;
  final String stage;
  final List<String> tags;
  final String equity;
  final String duration;
  final String location;
  final List<String> seekingRoles;
  final String imageUrl;

  const StartupProject({
    required this.id,
    required this.name,
    this.snippet = '',
    this.description = '',
    this.domain = '',
    this.founderId = '',
    this.stage = 'idea',
    this.tags = const [],
    this.equity = '',
    this.duration = '',
    this.location = '',
    this.seekingRoles = const [],
    this.imageUrl = '',
  });

  String get title => name;
  String get industry => domain;
  List<String> get rolesNeeded => seekingRoles;

  factory StartupProject.fromJson(Map<String, dynamic> json) {
    return StartupProject(
      id: json['id'] as String,
      name: (json['name'] ?? json['title']) as String,
      snippet: json['snippet'] as String? ?? '',
      description: json['description'] as String? ?? '',
      domain: (json['domain'] ?? json['industry']) as String? ?? '',
      founderId: json['founderId'] as String? ?? '',
      stage: json['stage'] as String? ?? 'idea',
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      equity: json['equity'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      location: json['location'] as String? ?? '',
      seekingRoles: (json['seekingRoles'] as List<dynamic>?)
              ?.cast<String>() ??
          (json['lookingFor'] as List<dynamic>?)?.cast<String>() ??
          (json['rolesNeeded'] as List<dynamic>?)?.cast<String>() ??
          [],
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  static StartupProject fromJsonRaw(Map<String, dynamic> json) =>
      StartupProject.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'snippet': snippet,
      'description': description,
      'domain': domain,
      'founderId': founderId,
      'stage': stage,
      'tags': tags,
      'equity': equity,
      'duration': duration,
      'location': location,
      'seekingRoles': seekingRoles,
      'imageUrl': imageUrl,
    };
  }

  static List<StartupProject> sampleProjects() {
    return [
      StartupProject(
        id: '1',
        name: 'HEALTHAI',
        snippet: 'AI-powered patient triage for clinics.',
        description: 'An AI-driven platform that helps clinics prioritize patients based on symptom severity. Uses NLP to analyze patient intake forms and recommends triage levels, reducing wait times by 40%. Built for small to medium clinics that lack dedicated triage nurses.',
        domain: 'AI',
        founderId: 'p1',
        stage: 'prototype',
        tags: ['AI', 'Healthcare', 'NLP'],
        equity: '2-5%',
        duration: '6 months',
        location: 'Remote',
        seekingRoles: ['Flutter Dev', 'UI Designer', 'ML Engineer'],
        imageUrl: '',
      ),
      StartupProject(
        id: '2',
        name: 'EDUSNAP',
        snippet: 'Micro-learning for high school students.',
        description: 'A mobile-first micro-learning app that turns complex subjects into bite-sized interactive lessons. Gamification, daily challenges, and peer competitions keep students engaged. Targets high school students preparing for competitive exams.',
        domain: 'EdTech',
        founderId: 'p2',
        stage: 'idea',
        tags: ['EdTech', 'Mobile', 'Gamification'],
        equity: '3-7%',
        duration: '4 months',
        location: 'New York, NY',
        seekingRoles: ['Flutter Dev', 'Content Creator', 'Backend Dev'],
        imageUrl: '',
      ),
      StartupProject(
        id: '3',
        name: 'CIVICCONNECT',
        snippet: 'Local government transparency platform.',
        description: 'A platform that bridges the gap between citizens and local government. Features include real-time tracking of municipal projects, public comment periods, town hall scheduling, and direct messaging with elected officials. Aims to increase civic engagement.',
        domain: 'GovTech',
        founderId: 'p3',
        stage: 'mvp',
        tags: ['GovTech', 'Civic', 'Platform'],
        equity: '2-4%',
        duration: '8 months',
        location: 'Washington, DC',
        seekingRoles: ['Flutter Dev', 'Backend Dev', 'DevOps'],
        imageUrl: '',
      ),
      StartupProject(
        id: '4',
        name: 'PACKLY',
        snippet: 'Smart package tracking for e-commerce.',
        description: 'Unified package tracking across all major carriers with AI-powered delivery predictions. Notifies users of delays before the carrier does. Integrates with Shopify, WooCommerce, and BigCommerce for seamless merchant onboarding.',
        domain: 'Logistics',
        founderId: 'p4',
        stage: 'mvp',
        tags: ['Logistics', 'E-commerce', 'AI'],
        equity: '1-3%',
        duration: '5 months',
        location: 'Remote',
        seekingRoles: ['Flutter Dev', 'Backend Dev', 'Data Scientist'],
        imageUrl: '',
      ),
      StartupProject(
        id: '5',
        name: 'GREENLEDGER',
        snippet: 'Carbon tracking for SMBs.',
        description: 'A simple carbon footprint tracker designed for small and medium businesses. Automated data ingestion from utility bills and shipping logs, with actionable recommendations to reduce emissions. Generates ESG reports for stakeholders.',
        domain: 'Climate',
        founderId: 'p5',
        stage: 'prototype',
        tags: ['Climate', 'SaaS', 'ESG'],
        equity: '2-6%',
        duration: '6 months',
        location: 'Austin, TX',
        seekingRoles: ['Flutter Dev', 'UI Designer', 'Backend Dev'],
        imageUrl: '',
      ),
    ];
  }
}

class Application {
  final String id;
  final String projectId;
  final String projectTitle;
  final String applicantId;
  final String applicantName;
  final String applicantRole;
  final String applicantAvatar;
  final String message;
  final String status; // pending, accepted, rejected
  final DateTime createdAt;

  Application({
    required this.id,
    required this.projectId,
    this.projectTitle = '',
    required this.applicantId,
    this.applicantName = '',
    this.applicantRole = '',
    this.applicantAvatar = '',
    this.message = '',
    this.status = 'pending',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      projectTitle: json['projectTitle'] as String? ?? '',
      applicantId: json['applicantId'] as String,
      applicantName: json['applicantName'] as String? ?? '',
      applicantRole: json['applicantRole'] as String? ?? '',
      applicantAvatar: json['applicantAvatar'] as String? ?? '',
      message: json['message'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectTitle': projectTitle,
      'applicantId': applicantId,
      'applicantName': applicantName,
      'applicantRole': applicantRole,
      'applicantAvatar': applicantAvatar,
      'message': message,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<Application> sampleApplications() {
    return [
      Application(
        id: 'a1',
        projectId: 'p1',
        projectTitle: 'LearnAI',
        applicantId: 'u5',
        applicantName: 'Jordan Kim',
        applicantRole: 'developer',
        applicantAvatar: '',
        message: 'Hey Alex! I love the idea of LearnAI. I have 4 years of Flutter experience and built a similar educational app. Would love to join!',
        status: 'pending',
      ),
      Application(
        id: 'a2',
        projectId: 'p1',
        projectTitle: 'LearnAI',
        applicantId: 'u6',
        applicantName: 'Taylor Williams',
        applicantRole: 'creative',
        applicantAvatar: '',
        message: 'This project is exactly what I\'ve been looking for. I can handle all the visual design and branding.',
        status: 'pending',
      ),
      Application(
        id: 'a3',
        projectId: 'p2',
        projectTitle: 'GreenRoute',
        applicantId: 'u7',
        applicantName: 'David Park',
        applicantRole: 'developer',
        applicantAvatar: '',
        message: 'I\'ve been working on similar ML models for route optimization. Let\'s connect!',
        status: 'accepted',
      ),
      Application(
        id: 'a4',
        projectId: 'p4',
        projectTitle: 'HealthPulse',
        applicantId: 'u10',
        applicantName: 'Maya Thompson',
        applicantRole: 'developer',
        applicantAvatar: '',
        message: 'Backend engineer here with experience building HIPAA-compliant systems.',
        status: 'pending',
      ),
      Application(
        id: 'a5',
        projectId: 'p5',
        projectTitle: 'ArtBlock',
        applicantId: 'u3',
        applicantName: 'Marcus Johnson',
        applicantRole: 'creative',
        applicantAvatar: '',
        message: 'I\'d love to design the ArtBlock experience. Let\'s make something beautiful!',
        status: 'rejected',
      ),
    ];
  }
}

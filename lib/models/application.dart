/// Model representing a user's application to a startup project.
enum ApplicationStatus { pending, accepted, rejected }

class Application {
  final String id;
  final String projectId;
  final String projectName;
  final String applicantId;
  final String coverNote;
  final DateTime appliedAt;
  final ApplicationStatus status;

  const Application({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.applicantId,
    required this.coverNote,
    required this.appliedAt,
    this.status = ApplicationStatus.pending,
  });

  Application copyWith({ApplicationStatus? status}) {
    return Application(
      id: id,
      projectId: projectId,
      projectName: projectName,
      applicantId: applicantId,
      coverNote: coverNote,
      appliedAt: appliedAt,
      status: status ?? this.status,
    );
  }
}

/// Mock applications for the logged-in user.
final List<Application> mockApplications = [
  Application(
    id: 'app_001',
    projectId: 'healthai',
    projectName: 'HEALTHAI',
    applicantId: 'current_user',
    coverNote: 'I am excited to contribute my Flutter skills to HealthAI!',
    appliedAt: DateTime(2026, 7, 10),
    status: ApplicationStatus.pending,
  ),
  Application(
    id: 'app_002',
    projectId: 'cryptoquest',
    projectName: 'CRYPTOQUEST',
    applicantId: 'current_user',
    coverNote: 'My Web3 and Dart expertise would be a great fit.',
    appliedAt: DateTime(2026, 7, 5),
    status: ApplicationStatus.accepted,
  ),
];

import 'package:flutter/foundation.dart';

class Application {
  final String id;
  final String projectId;
  final String projectName;
  final String applicantId;
  final String coverNote;
  final DateTime appliedAt;
  final ApplicationStatus status;

  Application({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.applicantId,
    this.coverNote = '',
    DateTime? appliedAt,
    this.status = ApplicationStatus.pending,
  }) : appliedAt = appliedAt ?? DateTime.now();

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      applicantId: json['applicantId'] as String,
      coverNote: json['coverNote'] as String? ?? '',
      appliedAt: json['appliedAt'] != null
          ? DateTime.parse(json['appliedAt'] as String)
          : null,
      status: applicationStatusFromString(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectName': projectName,
      'applicantId': applicantId,
      'coverNote': coverNote,
      'appliedAt': appliedAt.toIso8601String(),
      'status': status.name,
    };
  }

  static List<Application> sampleApplications() {
    return [
      Application(
        id: 'app1',
        projectId: '1',
        projectName: 'HEALTHAI',
        applicantId: 'user1',
        coverNote: 'I have experience building medical apps.',
        appliedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Application(
        id: 'app2',
        projectId: '2',
        projectName: 'EDUSNAP',
        applicantId: 'user2',
        coverNote: 'Love the concept! I can help with the UI.',
        appliedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}

enum ApplicationStatus { pending, approved, rejected }

ApplicationStatus applicationStatusFromString(String? s) {
  switch (s) {
    case 'approved':
      return ApplicationStatus.approved;
    case 'rejected':
      return ApplicationStatus.rejected;
    default:
      return ApplicationStatus.pending;
  }
}

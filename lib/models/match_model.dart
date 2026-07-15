class MatchModel {
  final String id;
  final String userId;
  final String matchedUserId;
  final DateTime createdAt;
  final bool isMutual;

  MatchModel({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.createdAt,
    this.isMutual = false,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      matchedUserId: json['matchedUserId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isMutual: json['isMutual'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'matchedUserId': matchedUserId,
      'createdAt': createdAt.toIso8601String(),
      'isMutual': isMutual,
    };
  }
}

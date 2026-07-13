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
}

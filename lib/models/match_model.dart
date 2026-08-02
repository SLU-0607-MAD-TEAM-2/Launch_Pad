import 'package:cloud_firestore/cloud_firestore.dart';

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
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.parse(value);
      return DateTime.now();
    }

    return MatchModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      matchedUserId: json['matchedUserId'] as String,
      createdAt: parseDate(json['createdAt']),
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

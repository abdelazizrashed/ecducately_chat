import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:equatable/equatable.dart';

class ConversationModel extends Equatable {
  final String id;
  final String lastMessage;
  final bool isActive;
  final DateTime? lastMessageTime;
  final List<String> participants;
  final UserModel? user;

  const ConversationModel({
    required this.id,
    required this.lastMessage,
    required this.participants,
    this.isActive = true,
    this.user,
    this.lastMessageTime,
  });

  static ConversationModel fromJsonFirestore(
      Map<String, dynamic> json, List<UserModel> users) {
    final participants =
        (json['participants'] as List? ?? []).map((e) => e.toString()).toList();
    final user = users
        .where((e) =>
            participants.contains(e.uid) && e.uid != AppSpMan.user.get()!.uid)
        .toList()
        .first;
    final time = json['lastMessageTime'] as Timestamp?;

    return ConversationModel(
      id: json['id'] ?? "",
      lastMessage: json['lastMessage'] ?? "",
      user: user,
      lastMessageTime: time?.toDate(),
      isActive: json['isActive'] ?? true,
      participants: (json['participants'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? "",
      lastMessage: json['lastMessage'] ?? "",
      isActive: json['isActive'] ?? true,
      participants: (json['participants'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'user': user,
      'participants': participants,
    };
  }

  @override
  List<Object?> get props => [
        id,
        lastMessage,
        user,
        lastMessageTime,
        participants,
      ];
}

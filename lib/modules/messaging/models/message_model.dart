import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final UserModel sender;
  final String text;
  final DateTime time;
  final String uuid;
  final bool isSent;

  const MessageModel({
    required this.sender,
    required this.text,
    required this.time,
    required this.uuid,
    required this.isSent,
  });

  static MessageModel fromJsonFirestore(
    Map<String, dynamic> json,
    List<UserModel> participants,
  ) {
    final time = json['time'] as Timestamp;
    final sender = json['sender'];
    return MessageModel(
      sender: participants.firstWhere((e) => e.uid == sender),
      text: json['text'] ?? "",
      time: time.toDate(),
      uuid: json['uuid'] ?? "",
      isSent: AppSpMan.user.get()!.uid == sender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'text': text,
      'time': time,
      'uuid': uuid,
      'isSent': isSent,
    };
  }

  @override
  List<Object?> get props => [sender, text, time];
}

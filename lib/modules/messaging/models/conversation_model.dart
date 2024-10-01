import 'package:equatable/equatable.dart';

class ConversationModel extends Equatable {
  final String id;
  final List<String> participants;

  const ConversationModel({
    required this.id,
    required this.participants,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? "",
      participants: (json['participants'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
    };
  }

  @override
  List<Object?> get props => [participants];
}

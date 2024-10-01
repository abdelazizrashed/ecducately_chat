part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsGetHistoryEvent extends ChatsEvent {}

class ChatsCreateConversationEvent extends ChatsEvent {
  final UserModel user;

  const ChatsCreateConversationEvent({required this.user});

  @override
  List<Object> get props => [user];
}

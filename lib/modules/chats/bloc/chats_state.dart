part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {}

class ChatsError extends ChatsState {
  final String message;

  const ChatsError(this.message);

  @override
  List<Object> get props => [message];
}

class ChatsNetworkConnectionError extends ChatsState {
  final String message;

  const ChatsNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

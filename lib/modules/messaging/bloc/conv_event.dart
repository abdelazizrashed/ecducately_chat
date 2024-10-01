part of 'conv_bloc.dart';

abstract class ConvEvent extends Equatable {
  const ConvEvent();

  @override
  List<Object> get props => [];
}

class ConvInitEvent extends ConvEvent {
  final String convId;
  const ConvInitEvent(this.convId);

  @override
  List<Object> get props => [convId];
}

class ConvInitTypingStream extends ConvEvent {}

class ConvInitOnlineStream extends ConvEvent {}

class ConvDeactvateEvent extends ConvEvent {}

class ConvSendMsgEvent extends ConvEvent {
  final String text;
  const ConvSendMsgEvent(this.text);

  @override
  List<Object> get props => [text];
}

class ConvSetTypingEvent extends ConvEvent {
  const ConvSetTypingEvent();
}

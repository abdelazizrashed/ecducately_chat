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

class ConvDeactvateEvent extends ConvEvent {}

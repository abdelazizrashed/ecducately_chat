part of 'conv_bloc.dart';

abstract class ConvState extends Equatable {
  const ConvState();

  @override
  List<Object> get props => [];
}

class ConvInitial extends ConvState {}

class ConvLoading extends ConvState {}

class ConvLoaded extends ConvState {
  /// Needed for triggering updates. Each State will be differnet.
  late String uuid;

  ConvLoaded() {
    uuid = const Uuid().v4();
  }

  @override
  List<Object> get props => [uuid];
}

class ConvError extends ConvState {
  final String message;

  const ConvError(this.message);

  @override
  List<Object> get props => [message];
}

class ConvNetworkConnectionError extends ConvState {
  final String message;

  const ConvNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

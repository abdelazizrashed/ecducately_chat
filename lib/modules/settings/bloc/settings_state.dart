part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  late final String _uuid;

  SettingsLoaded() {
    _uuid = const Uuid().v4();
  }

  @override
  List<Object> get props => [_uuid];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class SettingsNetworkConnectionError extends SettingsState {
  final String message;

  const SettingsNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

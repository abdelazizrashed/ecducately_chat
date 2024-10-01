part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  // final AuthModel data;
  //
  // const AuthLoaded(this.data);
  //
  // @override
  // List<Object> get props => [data];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthNetworkConnectionError extends AuthState {
  final String message;

  const AuthNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

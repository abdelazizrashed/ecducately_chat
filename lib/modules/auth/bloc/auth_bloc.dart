import 'dart:async';

import 'package:educately_chat/modules/auth/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc of(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  // To follow the standards data call (remote or local) should be handled
  // by the resource repository. For simplicity, I am not using it here.
  final AuthRepository _repository;

  AuthBloc({
    required AuthRepository repository,
  })  : _repository = repository,
        super(AuthInitial()) {
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthSignupEvent>(_onAuthSignEvent);
  }

  Future<void> _onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      print(credential);
      emit(AuthLoaded());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError('weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError('email-already-in-use'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthSignEvent(
      AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      credential.user.uid;
      print(credential);
      emit(AuthLoaded());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError('weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError('email-already-in-use'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

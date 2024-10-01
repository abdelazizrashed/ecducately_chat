import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/globals.dart';
import 'package:educately_chat/modules/auth/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
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
    on<AuthStartOnlineUpdate>(_onAuthStartOnlineUpdate);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);
  }

  Future<void> _onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await _repository.login(
      email: event.email,
      password: event.password,
      onError: (msg) => emit(AuthError(msg)),
    );
    if (user != null) {
      await AppSpMan.isLoggedIn.save(true);
      await AppSpMan.user.save(user);
      emit(AuthLoaded());
      await _startUpdatingOnlineStatus(emit);
    }
  }

  int updatePeriodSecs = 3;
  Stream? updateStatusStream;

  _startUpdatingOnlineStatus(Emitter<AuthState> emit) async {
    updateStatusStream =
        Stream.periodic(Duration(seconds: updatePeriodSecs), (i) async {
      final db = FirebaseFirestore.instance;
      final ref = db.collection("users").doc(AppSpMan.user.get()!.uid);
      final doc = await ref.get();
      var data = doc.data() ?? {};
      data["lastOnline"] = Timestamp.now();
      await ref.set(data);
      return i;
    });
    await emit.forEach(
      updateStatusStream!,
      onData: (event) {
        return AuthLoaded();
      },
    );
  }

  Future<void> _onAuthSignEvent(
      AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = await _repository.signup(
      email: event.email,
      password: event.password,
      name: event.name,
      onError: (msg) => emit(AuthError(msg)),
    );
    if (user != null) {
      await AppSpMan.isLoggedIn.save(true);
      await AppSpMan.user.save(user);

      emit(AuthLoaded());
      await _startUpdatingOnlineStatus(emit);
    }
  }

  Future<void> _onAuthStartOnlineUpdate(
      AuthStartOnlineUpdate event, Emitter<AuthState> emit) async {
    await _startUpdatingOnlineStatus(emit);
  }

  Future<void> _onAuthLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await AppSpMan.isLoggedIn.save(false);
    await AppSpMan.user.remove();
    // ignore: use_build_context_synchronously
    AppNavigator.goLoginScreen(navigatorKey.currentState!.context);
    emit(AuthInitial());
  }
}

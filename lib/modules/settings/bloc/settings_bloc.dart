import 'dart:async';

import 'package:educately_chat/config/app_sp_man.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static SettingsBloc of(BuildContext context) =>
      BlocProvider.of<SettingsBloc>(context);

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsChangeThemeEvent>(_onSettingsChangeThemeEvent);
  }

  bool isDarkMode = AppSpMan.isDarkMode.get() ?? false;

  Future<void> _onSettingsChangeThemeEvent(
      SettingsChangeThemeEvent event, Emitter<SettingsState> emit) async {
    isDarkMode = event.isDarkMode;
    await AppSpMan.isDarkMode.save(event.isDarkMode);
    emit(SettingsLoaded());
  }
}

import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/globals.dart';
import 'package:educately_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:educately_chat/modules/auth/repo/auth_repo.dart';
import 'package:educately_chat/modules/chats/bloc/chats_bloc.dart';
import 'package:educately_chat/modules/messaging/bloc/conv_bloc.dart';
import 'package:educately_chat/modules/search/bloc/search_bloc.dart';
import 'package:educately_chat/modules/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository.create()),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AuthBloc(
                  repository: AuthRepository.of(context),
                ),
              ),
              BlocProvider(
                create: (_) => ConvBloc(),
              ),
              BlocProvider(
                create: (_) => ChatsBloc(),
              ),
              BlocProvider(
                create: (_) => SettingsBloc(),
              ),
              BlocProvider(
                create: (_) => SearchBloc(),
              ),
            ],
            child: Builder(builder: (context) {
              return BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                return MaterialApp(
                  title: 'Educately Chat',
                  theme: theme().copyWith(
                    brightness: AppColors.brightness,
                  ),
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                  home: AppNavigator.home,
                );
              });
            }),
          );
        },
      ),
    );
  }
}

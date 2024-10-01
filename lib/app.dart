import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/globals.dart';
import 'package:educately_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:educately_chat/modules/auth/repo/auth_repo.dart';
import 'package:educately_chat/modules/messaging/bloc/conv_bloc.dart';
import 'package:educately_chat/modules/messaging/repo/conv_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository.create()),
        RepositoryProvider(create: (_) => ConvRepository.create()),
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
                create: (_) => ConvBloc(
                  repository: ConvRepository.of(context),
                ),
              ),
            ],
            child: Builder(builder: (context) {
              return MaterialApp(
                title: 'Educately Chat',
                theme: theme(),
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                scaffoldMessengerKey: scaffoldMessengerKey,
                home: AppNavigator.home,
              );
            }),
          );
        },
      ),
    );
  }
}

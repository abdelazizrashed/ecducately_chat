import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/globals.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: AppNavigator.home,
    );
  }
}

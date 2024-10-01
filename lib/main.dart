import 'package:educately_chat/app.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSpMan.init();
  runApp(const App());
}

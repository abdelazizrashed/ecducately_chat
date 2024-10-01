import 'package:educately_chat/app.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppSpMan.init();
  runApp(const App());
}

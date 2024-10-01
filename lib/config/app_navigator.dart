import 'package:educately_chat/modules/auth/login_screen.dart';
import 'package:educately_chat/modules/auth/signup_screen.dart';
import 'package:educately_chat/modules/messaging/conversation_screen.dart';
import 'package:flutter/material.dart';

/// This is an interface for the navigation. The purpose is consalidate
/// the navigation to a specific screen using a simple declartive syntax
/// instead of writing long boilerplate code.
/// (i.e. Navigator.of(context).push(MaterialRoute(builder: (context) => ...)))
/// You can change the specific navigation to your prefered
/// navigation method.
class AppNavigator {
  static Widget get home {
    // return const SignupScreen();
    return const LoginScreen();
    // return const ConversationScreen();
  }

  static void goLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  static void goSignupScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignupScreen()),
      (route) => false,
    );
  }

  static void goConversationScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ConversationScreen()),
      (route) => false,
    );
  }
}

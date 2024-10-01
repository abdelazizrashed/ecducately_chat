import 'package:educately_chat/modules/auth/repo/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthRepository {
  static AuthRepository of(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  static AuthRepository create() => AuthRepositoryImpl();
}

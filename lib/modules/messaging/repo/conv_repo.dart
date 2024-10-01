import 'package:educately_chat/modules/messaging/repo/conv_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConvRepository {
  static ConvRepository of(BuildContext context) =>
      RepositoryProvider.of<ConvRepository>(context);

  static ConvRepository create() => ConvRepositoryImpl();
}

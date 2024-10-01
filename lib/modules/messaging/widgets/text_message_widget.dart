import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/messaging/models/message_model.dart';
import 'package:flutter/material.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    super.key,
    required this.message,
  });
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message.text,
      style: context.textTheme.s14.w400.setColor(
        AppColors.text,
      ),
    );
  }
}

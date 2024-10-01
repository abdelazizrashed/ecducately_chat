import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/chats/models/conversation_model.dart';
import 'package:educately_chat/utils/datetime_utils.dart';
import 'package:flutter/material.dart';

class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget({
    super.key,
    required this.model,
  });

  final ConversationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppNavigator.goConversationScreen(context, convId: model.id),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                model.user!.photo,
                height: 50.r,
                width: 50.r,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.user!.name,
                    style: context.textTheme.s18.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.lastMessage,
                    style:
                        context.textTheme.s12.w400.setColor(AppColors.subtext),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              DateTimeUtils.getChatTime(model.lastMessageTime!),
              style: context.textTheme.s12.w400.setColor(AppColors.subtext),
            ),
          ],
        ),
      ),
    );
  }
}

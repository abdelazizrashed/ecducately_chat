import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/messaging/models/conv_message_model.dart';
import 'package:educately_chat/modules/messaging/test_data/msg_model_test.dart';
import 'package:educately_chat/modules/messaging/widgets/conv_message_widget.dart';
import 'package:educately_chat/modules/messaging/widgets/convo_bottom_controls.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      // backgroundColor: ,
      body: Container(
        width: context.width,
        height: context.height,
        decoration: _getBackgroundDecoration(),
        child: Column(
          children: [
            Expanded(
              child: _buildMsgs(context, testMsgs),
            ),
            SizedBox(
              height: 8.h,
            ),
            const ConvoBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildMsgs(BuildContext context, List<ConvMessageModel> msgs) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListView.separated(
        itemCount: msgs.length + 1,
        padding: EdgeInsets.zero,
        reverse: true,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 2.h,
        ),
        itemBuilder: (context, index) {
          // Extra padding so we can see the content behind the appBar
          if (index == msgs.length) {
            return SizedBox(
              height: 110.h,
            );
          }
          final msg = msgs[index];
          bool isSecondary = false;
          if (index != 0) {
            // if multiple consecutive messages from same user don't show
            // name or photo
            if (msgs[index - 1].userId == msg.userId) {
              isSecondary = true;
            }
          }
          return MessageWidget(
            message: msg,
            isSecondary: isSecondary,
            // status: status,
          );
        },
      ),
    );
  }

  BoxDecoration _getBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.isDarkMode ? AppColors.scaffold : null,
      gradient: AppColors.isDarkMode
          ? null
          : LinearGradient(
              colors: [
                Colors.green.shade200,
                Colors.green,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: AppColors.appBar,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // TODO (abdelaziz): Goback
            },
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Sebastian",
                  style: context.textTheme.s18.w800,
                ),
                Text(
                  "last seen recently",
                  style: context.textTheme.s14.w400.setColor(AppColors.subtext),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.network(
              img1,
              width: 37.r,
              height: 37.r,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
    if (!AppColors.isDarkMode) {
      return appBar;
    }
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        50.0.h,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: appBar,
        ),
      ),
    );
  }
}

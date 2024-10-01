import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(AppColors.isDarkMode);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // TODO (abdelaziz): Fix App Bar
      // appBar: _buildAppBar(),
      // backgroundColor: ,
      body: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
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
        ),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text('Conversation Screen'),
              ),
            ),
            _buildBottomControls(context)
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: AppColors.appBar,
    );
    if (!AppColors.isDarkMode) {
      return appBar;
    }
    return PreferredSize(
      preferredSize: const Size(
        double.infinity,
        56.0,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: appBar,
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.background,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  // TODO (abdelaziz): Implement attachment
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Assets.icons.attachment.image(
                    height: 32.h,
                    color: AppColors.icon,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 32.h,
                    child: TextField(
                      scrollPadding: EdgeInsets.zero,
                      // TODO (abdelaziz): Add Controller from bloc
                      // controller: controller,
                      onChanged: (val) {
                        // TODO (abdelaziz): Implement typing
                      },
                      onSubmitted: (val) {
                        // TODO (abdelaziz): Implement send
                      },
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 7.h, horizontal: 12.h),
                          fillColor: AppColors.scaffold,
                          hintText: AppStrings.message,
                          suffixIcon: Assets.icons.sticker.image(height: 32.h)),
                    ),
                  ),
                ),
              ),
              InkWell(
                // onTap: _recordAudio,
                child: Assets.icons.microphone.image(
                  height: 32.h,
                  color: AppColors.icon,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          )
        ],
      ),
    );
  }
}

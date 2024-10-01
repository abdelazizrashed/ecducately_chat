import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ConvoBottomControls extends StatelessWidget {
  const ConvoBottomControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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

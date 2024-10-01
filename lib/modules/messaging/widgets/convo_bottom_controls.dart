import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/gen/assets.gen.dart';
import 'package:educately_chat/modules/messaging/bloc/conv_bloc.dart';
import 'package:flutter/material.dart';

class ConvoBottomControls extends StatefulWidget {
  const ConvoBottomControls({
    super.key,
  });

  @override
  State<ConvoBottomControls> createState() => _ConvoBottomControlsState();
}

class _ConvoBottomControlsState extends State<ConvoBottomControls> {
  final controller = TextEditingController();

  bool showSend = false;

  _sendMsgs(String msg) {
    if (msg.trim().isNotEmpty) {
      ConvBloc.of(context).add(ConvSendMsgEvent(msg));
      controller.clear();
      showSend = false;
      setState(() {});
    }
  }

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
                onTap: () async {
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
                      controller: controller,
                      onChanged: (val) {
                        if (val.trim().isNotEmpty) {
                          setState(() {
                            showSend = true;
                          });
                        } else {
                          setState(() {
                            showSend = false;
                          });
                        }
                        ConvBloc.of(context).add(const ConvSetTypingEvent());
                      },
                      onSubmitted: _sendMsgs,
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
              if (showSend)
                InkWell(
                  onTap: () => _sendMsgs(controller.text),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.blue,
                  ),
                ),
              if (!showSend)
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

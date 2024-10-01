import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/messaging/models/conv_message_model.dart';
import 'package:educately_chat/modules/messaging/widgets/text_message_widget.dart';
import 'package:educately_chat/utils/datetime_utils.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.isSecondary,
    required this.message,
  });
  final bool isSecondary;
  final ConvMessageModel message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    super.initState();
  }

  BorderRadius _getBorderRadius() {
    if (widget.isSecondary) {
      return BorderRadius.circular(16.r);
    }
    if (widget.message.isSent) {
      return BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
        bottomLeft: Radius.circular(16.r),
      );
    }
    return BorderRadius.only(
      topRight: Radius.circular(16.r),
      bottomRight: Radius.circular(16.r),
      bottomLeft: Radius.circular(16.r),
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final isSent = widget.message.isSent;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: isSent
          ? _buildMessage(context)
          : Row(
              children: [
                if (widget.isSecondary)
                  SizedBox(
                    width: 30.r,
                  ),
                if (!widget.isSecondary)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(42.r),
                    child: Image.network(
                      widget.message.profilePic,
                      width: 30.r,
                      height: 30.r,
                    ),
                  ),
                SizedBox(
                  width: 5.w,
                ),
                _buildMessage(context),
              ],
            ),
    );
  }

  Container _buildMessage(BuildContext context) {
    final isSent = widget.message.isSent;
    final size = _getSize(context);
    return Container(
      // width: 160.w,
      constraints: BoxConstraints(
        maxWidth: 260.w,
      ),
      padding: _getMessagePadding(),
      decoration: BoxDecoration(
        color: AppColors.message(isSent),
        borderRadius: _getBorderRadius(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSent && !widget.isSecondary)
            Text(
              widget.message.username,
              style:
                  context.textTheme.s12.w600.setColor(const Color(0xff00A700)),
            ),
          if (!isSent)
            SizedBox(
              height: 5.h,
            ),
          _buildContent(context),
          SizedBox(
            width: size.width + 50.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateTimeUtils.getMessageTime(widget.message.time),
                  style: context.textTheme.s12.w400
                      .setColor(const Color(0xff989E9C)),
                ),
                if (isSent)
                  SizedBox(
                    width: 5.w,
                  ),
                // if (isSent) widget.status.icon
              ],
            ),
          )
        ],
      ),
    );
  }

  EdgeInsets _getMessagePadding() {
    final padding = EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 8.h,
    );
    // TODO (abdelaziz): Add differnt message types
    // if (widget.isSecondary) {
    //   return padding.copyWith(bottom: 7.h);
    // }
    return padding;
  }

  Size _getSize(BuildContext context) {
    // TODO (abdelaziz): Add differnt msg types
    return _textSize(
      widget.message.text,
      context.textTheme.s12.w400.setColor(AppColors.subtext),
    );
  }

  Widget _buildContent(BuildContext context) {
    // TODO (abdelaziz): Add differnt message types
    return TextMessageWidget(message: widget.message);
  }
}

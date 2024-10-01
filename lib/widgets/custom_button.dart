import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.loading = false,
    this.isTransparent = false,
    this.color,
    this.padding,
  });

  final String text;
  final bool loading;
  final bool isTransparent;
  final Color? color;
  final EdgeInsets? padding;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color:
              color ?? (isTransparent ? Colors.transparent : AppColors.button),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  height: 15.r,
                  width: 15.r,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: context.textTheme.s14.w600
                      .setColor(isTransparent ? AppColors.text : Colors.white),
                ),
        ),
      ),
    );
  }
}

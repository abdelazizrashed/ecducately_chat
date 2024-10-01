import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:educately_chat/modules/settings/bloc/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(AppStrings.settings),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.darkModel,
                          style: context.textTheme.s16.w500,
                        ),
                      ),
                      CupertinoSwitch(
                        value: AppSpMan.isDarkMode.get() ?? false,
                        onChanged: (value) async {
                          SettingsBloc.of(context)
                              .add(SettingsChangeThemeEvent(isDarkMode: value));
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                InkWell(
                  onTap: () {
                    AuthBloc.of(context).add(AuthLogoutEvent());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Logout",
                            style: context.textTheme.s16.w500,
                          ),
                        ),
                        const Icon(Icons.logout)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

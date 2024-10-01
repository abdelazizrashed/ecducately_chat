import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            _buildInputForm(),
            SizedBox(
              height: 8.h,
            ),
            // _buildRememberMeAndForogotPass(context),
            SizedBox(
              height: 48.h,
            ),
            CustomButton(
              // TODO (abdelaziz):update loading
              text: AppStrings.login,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  // TODO (abdelaziz): Submit
                }
              },
            ),

            SizedBox(
              height: 8.h,
            ),
            InkWell(
              onTap: () {
                AppNavigator.goSignupScreen(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      AppStrings.dontHaveAnAccount,
                      style: context.textTheme.s14.w400,
                    ),
                    Text(
                      AppStrings.signup,
                      style: context.textTheme.s14.w700,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            // controller: emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: AppStrings.emailAddress,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormField(
            // controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: AppStrings.password,
            ),
          ),
        ],
      ),
    );
  }
}

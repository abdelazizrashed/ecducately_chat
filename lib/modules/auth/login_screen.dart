import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/auth/bloc/auth_bloc.dart';
import 'package:educately_chat/utils/showtoast.dart';
import 'package:educately_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = AuthBloc.of(context);
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
            SizedBox(
              height: 48.h,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  AppNavigator.goChatsScreen(context);
                }
                if (state is AuthError) {
                  showToast(msg: state.message, isError: true);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  loading: state is AuthLoading,
                  text: AppStrings.login,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      bloc.add(
                        AuthLoginEvent(
                          emailController.text,
                          passwordController.text,
                        ),
                      );
                    }
                  },
                );
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
            controller: emailController,
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
            controller: passwordController,
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

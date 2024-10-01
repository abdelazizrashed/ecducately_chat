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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            // _buildRememberMeAndForogotPass(context),
            SizedBox(
              height: 48.h,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  AppNavigator.goConversationScreen(context);
                }
                if (state is AuthError) {
                  showToast(msg: state.message, isError: true);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  loading: state is AuthLoading,
                  text: AppStrings.signup,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      bloc.add(
                        AuthSignupEvent(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
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
                AppNavigator.goLoginScreen(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      AppStrings.alreadyHaveAnAccount,
                      style: context.textTheme.s14.w400,
                    ),
                    Text(
                      AppStrings.login,
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
            controller: nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              hintText: AppStrings.name,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
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

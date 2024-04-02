import 'package:finch/config/extensions.dart';
import 'package:finch/enums/enums.dart';
import 'package:finch/provider/authentication/auth_provider.dart';
import 'package:finch/shared/utils/message.dart';
import 'package:finch/shared/widgets/busy_overlay.dart';
import 'package:finch/shared/widgets/custom_button.dart';
import 'package:finch/styles/color.dart';
import 'package:finch/styles/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(
        builder: (context, stateModel, child) {
      return BusyOverlay(
        show: stateModel.state == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: AppTheme.headerStyle(color: whiteColor),
                    ),
                    10.height(),
                    Image.asset('assets/images/finch.jpg'),
                    10.height(),
                    CustomTextField(
                      stateModel.emailController,
                      hint: 'Email',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    20.height(),
                    CustomTextField(
                      stateModel.passwordController,
                      hint: 'Password',
                      password: true,
                      border: Border.all(color: greyColor),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: Text(
                          'Forgot password',
                          style: AppTheme.titleStyle(
                              color: primaryColor, isBold: true),
                        ),
                        onPressed: () {
                          context.go('/forgot_password');
                        },
                      ),
                    ),
                    70.height(),
                    CustomButton(
                      onPressed: () async {
                        if (stateModel.passwordController.text.isEmpty) {
                          showMessage(context, 'All fields are required',
                              isError: true);
                          return;
                        }
                        if (!FlutterUtilities().isEmailValid(
                            stateModel.emailController.text.trim())) {
                          showMessage(context, "Invalid email provided",
                              isError: true);
                          return;
                        }

                        await stateModel.loginUser();

                        if (stateModel.state == ViewState.Error) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message,
                                isError: true);
                          }
                          return;
                        }
                        if (stateModel.state == ViewState.Success) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message);
                            context.go('/loan_dashboard');
                          }
                        }
                      },
                      text: 'Login',
                    ),
                    50.height(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: AppTheme.titleStyle(
                            color: whiteColor, isBold: true),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: AppTheme.titleStyle(
                            color: primaryColor, isBold: true),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/register_screen');
                          },
                      )
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

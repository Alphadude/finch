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
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                      'Reset Password',
                      style: AppTheme.headerStyle(color: whiteColor),
                    ),
                    20.height(),
                    Image.asset('assets/images/finch.jpg'),
                    20.height(),
                    CustomTextField(
                      stateModel.emailController,
                      hint: 'Email',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    100.height(),
                    CustomButton(
                      onPressed: () async {
                        if (!FlutterUtilities().isEmailValid(
                            stateModel.emailController.text.trim())) {
                          showMessage(context, "Invalid email provided",
                              isError: true);
                          return;
                        }

                        await stateModel.resetPassword();

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
                            context.go('/login_screen');
                          }
                        }
                      },
                      text: 'Reset Password',
                    ),
                    50.height(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Remember Password? ",
                        style: AppTheme.titleStyle(
                            color: whiteColor, isBold: true),
                      ),
                      TextSpan(
                        text: "Log in",
                        style: AppTheme.titleStyle(
                            color: primaryColor, isBold: true),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/login_screen');
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

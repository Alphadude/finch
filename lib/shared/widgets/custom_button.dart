import 'package:finch/styles/color.dart';
import 'package:finch/styles/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? width;
  const CustomButton(
      {super.key, required this.onPressed, this.text = 'Continue', this.width});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(width ?? MediaQuery.of(context).size.width, 0)),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => primaryColor)),
      child: Text(
        text,
        style: AppTheme.titleStyle(color: whiteColor),
      ),
    );
  }
}

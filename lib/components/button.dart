import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final String text;
  final Widget? textWidget;

  const ButtonPrimary(
      {required this.onPressed,
      required this.text,
      this.color = Colors.red,
      this.textWidget,
      this.textColor = Colors.white,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(color!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        onPressed: onPressed,
        child: textWidget ??
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
      ),
    );
  }
}

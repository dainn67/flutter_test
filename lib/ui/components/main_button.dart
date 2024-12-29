import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.lightBlue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

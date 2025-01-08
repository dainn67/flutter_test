import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final bool isSelected;
  final bool isLoading;

  const MainButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: isSelected ? Colors.lightBlue : Colors.transparent,
      textColor: isSelected ? Colors.white : Colors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.lightBlue),
      ),
      elevation: 0,
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
                strokeCap: StrokeCap.round,
                strokeWidth: 3,
              ),
            )
          : Text(title),
    );
  }
}

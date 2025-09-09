import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    required this.onPressed,
    required this.child,
    this.bacgroundColor,
    super.key,
  });
  final void Function()? onPressed;
  final Widget child;
  final Color? bacgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,

        backgroundColor: bacgroundColor,
      ),
      child: child,
    );
  }
}

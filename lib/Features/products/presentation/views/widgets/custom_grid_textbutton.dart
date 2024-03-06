import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.title,
      required this.color,
      required this.icon,
      required this.onPressed});
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton.icon(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(1),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(16))),
        onPressed: onPressed,
        icon: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        label: Icon(
          icon,
          color: color,
          size: 16,
          shadows: const [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
          ],
        ),
      ),
    );
  }
}

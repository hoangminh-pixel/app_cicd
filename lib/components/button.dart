import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final Function() opTap;

  const ButtonApp(
      {super.key,
      this.backgroundColor = const Color(0xFFFF4500),
      required this.title,
      required this.opTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: opTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(18)),
        height: 56,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

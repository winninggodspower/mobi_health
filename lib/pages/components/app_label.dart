import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  final String textContent;

  const AppLabel({
    super.key,
    required this.textContent
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 19.22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF384252),
          ));
  }
}
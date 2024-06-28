
import 'package:flutter/material.dart';

class authQuestion extends StatelessWidget {
  final String redirect_route;
  final String question_text;
  final String action_text;

  const authQuestion({
    super.key,
    required this.question_text,
    required this.action_text,
    required this.redirect_route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          question_text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, redirect_route),
          child: Text(
            action_text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}

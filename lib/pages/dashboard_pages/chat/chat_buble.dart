import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;

  const ChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth * 0.7;
      return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth:
                  maxWidth, // Set the maximum width to 70% of the screen width
            ),
            decoration: BoxDecoration(
              color: AppColors.primary_200Color,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              message,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.primary_800Color,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: isMe ? TextAlign.end : TextAlign.start,
            ),
          ),
        ],
      );
    });
  }
}

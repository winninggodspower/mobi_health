import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart'; // Ensure you have this import if needed

class ArticleCard extends StatelessWidget {
  final String title;
  final String bodyText;
  final String imagePath;
  final String tag;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.bodyText,
    required this.imagePath,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary_200Color, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7.5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      color: AppColors.primary100Color,
                      child: Text(
                        tag,
                        style: GoogleFonts.alegreya(
                          color: AppColors.secondary_700Color,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  bodyText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff371B34),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Read',
                      style: GoogleFonts.alegreya(
                        fontSize: 20,
                        color: AppColors.secondary_700Color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.secondary_700Color,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(1.2),
            color: const Color(0xffEDE6FC),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

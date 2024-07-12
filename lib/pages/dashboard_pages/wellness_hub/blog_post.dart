import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class BlogPost extends StatelessWidget {
  final String title;
  final String bodyText;
  final String date;

  const BlogPost({
    Key? key,
    required this.title,
    required this.bodyText,
    required this.date,
  }) : super(key: key);

  void _shareContent(BuildContext context) {
    final String content = 'Check out this article: $title';
    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
          child: ListView(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/blog-image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 26,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      _shareContent(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 19),
              Text(
                'by Robert E. | $date',
                style: GoogleFonts.domine(
                  fontSize: 12,
                  color: const Color(0xff959595),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                bodyText,
                style: GoogleFonts.alegreyaSans(
                  fontSize: 16,
                  height: 30.4 / 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
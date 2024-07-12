import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';


class BlogPost extends StatelessWidget {
  const BlogPost({super.key});

  void _shareContent(BuildContext context) {
    const String content = 'Check out this article: Stages of Pregnancy and preparing for them';
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
                      fit: BoxFit.cover
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, weight: 40, color: Colors.white,),
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
                      'Stages of Pregnancy and preparing for them',
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
              const SizedBox(height: 19,),
              Text(
                'by Robert E. | 28 January ',
                style: GoogleFonts.domine(
                  fontSize: 12,
                  color: const Color(0xff959595),
                ),
              ),
              const SizedBox(height: 18,),
              Text(
              '''Candi Borobudur’s design was conceived of by the poet, thinker, and architect Gunadharma, considered by many today to be a man of great vision and devotion. The temple has been described in a number of ways. Its basic structure resembles that of a pyramid, yet it has been also referred to as a caitya (shrine), a stupa (reliquary), and a sacred mountain. In fact, the name Śailendra literally means “Lord of the Mountain.” While the temple exhibits characteristics of all these architectural configurations, its overall plan is that of a three-dimensional mandala—a diagram of the cosmos used for meditation—and it is in that sense where the richest understanding of the monument occurs. Set high upon a hill vertically enhanced by its builders to achieve a greater elevation, Borobudur consists of a series of open-air passageways that radiate around a central axis mundi (cosmic axis).  Devotees circumambulate clockwise along walkways that gradually ascend to its uppermost level. At Borobudur, geometry, geomancy, and theology all instruct adherents toward the ultimate goal of enlightenment. Meticulously carved relief sculptures mediate a physical and spiritual journey that guides pilgrims progressively toward higher states of consciousness.
              ''',
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


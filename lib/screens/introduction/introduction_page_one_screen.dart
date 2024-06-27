import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecofurnish/res/colors/app_colors.dart';

class IntroductionPageOneScreen extends StatelessWidget {
  const IntroductionPageOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(1, 249, 249, 249),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(110),
            child: Image.network(
              'https://s3u.tmimgcdn.com/800x0/u33647109/8f0916dbce24f8b4e21e78a839f3a93c.jpg',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Text(
              'Boltunk prémium bútorokkal kereskedik, amely hatalmas kínálattal rendelkezik!',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                  color: AppColors().textColorFirst,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

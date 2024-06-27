import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecofurnish/res/colors/app_colors.dart';

class IntroductionPageThreeScreen extends StatelessWidget {
  const IntroductionPageThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://cdn-icons-png.flaticon.com/512/318/318417.png',
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
            '4 éves garancia mellett 1 hónapig visszaküldheted a terméket, ha nem tetszik.',
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
    );
  }
}

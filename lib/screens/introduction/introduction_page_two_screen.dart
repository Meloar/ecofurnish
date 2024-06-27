import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecofurnish/res/colors/app_colors.dart';

class IntroductionPageTwoScreen extends StatelessWidget {
  const IntroductionPageTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(110),
          child: Image.network(
            'https://images.assetsdelivery.com/compings_v2/jovanas/jovanas2007/jovanas200700364.jpg',
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
            'Rendelésed után igyekszünk a leghamarabb útjára bocsátani a csomagodat, hogy biztosítsuk az elégedettséget.',
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

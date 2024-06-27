import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_route/auto_route.dart';

import 'package:ecofurnish/screens/introduction/introduction_page_one_screen.dart';
import 'package:ecofurnish/screens/introduction/introduction_page_two_screen.dart';
import 'package:ecofurnish/screens/introduction/introduction_page_three_screen.dart';
import 'package:ecofurnish/res/colors/app_colors.dart';
import 'package:ecofurnish/routes/app_router.gr.dart';

@RoutePage()
class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() {
    return _IntroductionScreenState();
  }
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroductionPageOneScreen(),
              IntroductionPageTwoScreen(),
              IntroductionPageThreeScreen(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Kihagyás',
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: SlideEffect(
                    dotColor: Colors.white,
                    activeDotColor: AppColors().buttonColorFirst,
                  ),
                ),
                onLastPage
                    ? TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            const LoginRoute(),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Kész'),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Tovább'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/res/colors/app_colors.dart';
import 'package:ecofurnish/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    super.key,
  });

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, value, child) => Drawer(
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const UnderlineTabIndicator(
                  borderSide: BorderSide(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            AutoRouter.of(context).maybePop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Üdv, ${value.getUserData().name}',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'HOME',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: (value.drawerIndex == 1)
                          ? FontWeight.bold
                          : FontWeight.w300,
                      color: AppColors().textColorFirst,
                    ),
                  ),
                ),
                onTap: () {
                  AutoRouter.of(context).maybePop();
                  if (value.drawerIndex == 2) {
                    value.homeDrawerScreen();
                    AutoRouter.of(context).replaceAll([
                      HomeRoute(
                        token: value.getToken(),
                      ),
                    ]);
                  }
                },
              ),
              ListTile(
                title: Text(
                  'KOSÁR',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: (value.drawerIndex == 2)
                          ? FontWeight.bold
                          : FontWeight.w300,
                      color: AppColors().textColorFirst,
                    ),
                  ),
                ),
                onTap: () {
                  AutoRouter.of(context).maybePop();
                  if (value.drawerIndex == 1) {
                    value.cartDrawerScreen();
                    AutoRouter.of(context).replaceAll([
                      const CartRoute(),
                    ]);
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors().buttonColorSecond,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                ),
                onPressed: () {
                  value.homeDrawerScreen();
                  value.logOut();
                  AutoRouter.of(context).replaceAll([const LoginRoute()]);
                },
                child: const Text(
                  'Kijelentkezés',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

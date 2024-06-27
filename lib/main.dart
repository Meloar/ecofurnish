import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/routes/app_router.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(const Ecofurnish());
  });
}

class Ecofurnish extends StatelessWidget {
  const Ecofurnish({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return ChangeNotifierProvider(
      create: (context) => Data(),
      builder: (context, child) => MaterialApp.router(
        routerConfig: appRouter.config(),
        title: 'Ecofurnish',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme:
              const AppBarTheme().copyWith(surfaceTintColor: Colors.white),
        ),
      ),
    );
  }
}

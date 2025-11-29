import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_app/constants/routes/app_routers.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.aliceBlue,
          surface: AppColors.aliceBlue,
        ),
        scaffoldBackgroundColor: AppColors.aliceBlue,
        textTheme: GoogleFonts.notoSansJpTextTheme(),
      ),
      routerConfig: AppRouters.router,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// ゲームの設定画面
///
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ここはゲームの設定画面'),
            CommonButton(
              bgColor: AppColors.strawberryRed,
              children: Text(
                'topへ',
                style: TextStyle(color: AppColors.accentColor),
              ),
              tapFunc: () {
                context.go(AppRoutes.top);
              },
            ),
          ],
        ),
      ),
    );
  }
}

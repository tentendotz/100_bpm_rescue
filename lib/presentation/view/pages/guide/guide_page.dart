import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// ゲームの遊び方画面
///
class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ここは遊び方画面'),
            SizedBox(height: AppSize.sm),
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

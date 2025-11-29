import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// 心臓マッサージ時の持ち方画面
///
class GripGuidePage extends StatelessWidget {
  const GripGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 中央: 持ち方説明
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 画像
                  Image.asset(
                    'assets/images/grip_guide.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: AppSize.sm),
                  // タイトル（右に寄せる）
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      'スマホのもちかた',
                      style: TextStyle(
                        fontSize: AppSize.lg,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepSpaceBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.xs),
                  // 説明文（右に寄せる）
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      '両手でしっかりもって\n画面にふれないようにしてね！',
                      style: TextStyle(
                        fontSize: AppSize.md,
                        color: AppColors.subtitleGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 左上: タイトル
            const Positioned(
              left: AppSize.md,
              top: AppSize.sm,
              child: Text(
                'もちかた',
                style: TextStyle(
                  fontSize: AppSize.titleTextSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azureBlue,
                ),
              ),
            ),
            // 右下: 戻るボタン
            Positioned(
              right: AppSize.zero,
              bottom: AppSize.sm,
              child: CommonButton(
                children: const Text(
                  'もどる',
                  style: TextStyle(
                    fontSize: AppSize.md,
                    color: AppColors.accentColor,
                  ),
                ),
                tapFunc: () {
                  context.go(AppRoutes.top);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

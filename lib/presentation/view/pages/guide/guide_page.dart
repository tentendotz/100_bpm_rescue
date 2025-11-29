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
      body: SafeArea(
        child: Stack(
          children: [
            // 中央: ステップ1とステップ2
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ステップ1
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 3) - AppSize.lg,
                    child: _buildGuideStep(
                      stepNumber: '1',
                      imagePath: 'assets/images/chara/cat_speak_loudly.png',
                      title: '大きな声で よびかけ！',
                      descriptions: [
                        '「だいじょうぶですかー？」',
                        'ってスマホにむかって',
                        '大きな声で さけぼう！',
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSize.xxs),
                  // ステップ2
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 3) - AppSize.lg,
                    child: _buildGuideStep(
                      stepNumber: '2',
                      imagePath: 'assets/images/chara/cat_heart_massage.png',
                      title: 'しんぞうマッサージ！',
                      descriptions: ['スマホを両手でもって', '上↑下↓上↑下↓', 'ブルブルしたらせいかい！'],
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
                'あそびかた',
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
                  'もちかたへ',
                  style: TextStyle(
                    fontSize: AppSize.md,
                    color: AppColors.accentColor,
                  ),
                ),
                tapFunc: () {
                  context.go(AppRoutes.gripGuide);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 遊び方の各ステップを構築
  Widget _buildGuideStep({
    required String stepNumber,
    required String imagePath,
    required String title,
    required List<String> descriptions,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // キャラクター画像
        Flexible(
          child: Image.asset(imagePath, height: 200, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppSize.xxs),
        // タイトル&ステップ番号
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSize.xxs,
          children: [
            Container(
              width: AppSize.xxl,
              height: AppSize.xxl,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.strawberryRed,
              ),
              child: Center(
                child: Text(
                  stepNumber,
                  style: const TextStyle(
                    fontSize: AppSize.nm,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppSize.md,
                fontWeight: FontWeight.bold,
                color: AppColors.deepSpaceBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.xxs),
        // 説明文
        ...descriptions.map(
          (text) => Text(
            text,
            style: const TextStyle(
              fontSize: AppSize.sm,
              color: AppColors.subtitleGray,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

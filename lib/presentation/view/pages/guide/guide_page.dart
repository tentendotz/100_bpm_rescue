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
            // メインコンテンツ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
              child: Row(
                children: [
                  // ステップ1: 大声で呼びかけ（タイトル付き）
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // あそびかたタイトル
                        const Text(
                          'あそびかた',
                          style: TextStyle(
                            fontSize: AppSize.titleTextSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.strawberryRed,
                          ),
                        ),
                        const SizedBox(height: AppSize.sm),
                        // ステップ1
                        _buildGuideStep(
                          stepNumber: '1',
                          imagePath: 'assets/images/chara/cat_speak_loudly.png',
                          title: '大きな声で呼びかけ',
                          descriptions: ['「大丈夫ですかー？」と', 'スマホに向かって叫ぼう！'],
                        ),
                      ],
                    ),
                  ),
                  // ステップ2: 心臓マッサージ（タイトル分のスペース確保）
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // あそびかたタイトルと同じ高さの透明テキスト
                        const Opacity(
                          opacity: 0,
                          child: Text(
                            'あそびかた',
                            style: TextStyle(
                              fontSize: AppSize.titleTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.sm),
                        // ステップ2
                        _buildGuideStep(
                          stepNumber: '2',
                          imagePath:
                              'assets/images/chara/cat_heart_massage.png',
                          title: '心臓マッサージ',
                          descriptions: [
                            'スマホを両手で持って',
                            '上下運動をしよう！',
                            '振動が来ればOK！',
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 右下: 戻るボタン
            Positioned(
              right: AppSize.xxs,
              bottom: AppSize.md,
              child: CommonButton(
                bgColor: AppColors.strawberryRed,
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
        // ステップ番号
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.strawberryRed,
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSize.xs),
        // キャラクター画像
        Flexible(
          child: Image.asset(imagePath, height: 120, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppSize.xs),
        // タイトル
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSize.md,
            fontWeight: FontWeight.bold,
            color: AppColors.deepSpaceBlue,
          ),
        ),
        const SizedBox(height: 4),
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

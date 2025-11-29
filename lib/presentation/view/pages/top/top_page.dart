import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// トップ画面
///
class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  double topBtnWidth = AppSize.defaultBtnWidth * 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左半分：キャラクター画像
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/chara/cat_start.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 右半分：タイトルとボタン
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSize.sm,
                children: <Widget>[
                  const Text(
                    'リズムでレスキュー',
                    style: TextStyle(
                      fontSize: AppSize.titleTextSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.strawberryRed,
                    ),
                  ),
                  const Text(
                    'たのしくリズムにのって、いのちをまもろう！',
                    style: TextStyle(
                      fontSize: AppSize.xl,
                      color: AppColors.subtitleGray,
                    ),
                  ),
                  SizedBox(height: AppSize.sm),
                  CommonButton(
                    btnWidth: topBtnWidth,
                    children: Text(
                      'スタート',
                      style: TextStyle(
                        fontSize: AppSize.md,
                        color: AppColors.accentColor,
                      ),
                    ),
                    tapFunc: () {
                      context.go(AppRoutes.ready);
                    },
                  ),

                  /// TODO: 心臓マッサージ画面への遷移確認時に追加・完成時に削除
                  // CommonButton(
                  //   bgColor: AppColors.strawberryRed,
                  //   children: Text(
                  //     '心臓マッサージ画面へ',
                  //     style: TextStyle(color: AppColors.accentColor),
                  //   ),
                  //   tapFunc: () {
                  //     context.go(AppRoutes.game);
                  //   },
                  // ),
                  SizedBox(height: AppSize.sm),
                  CommonButton(
                    btnWidth: topBtnWidth,
                    bgColor: AppColors.strawberryRed,
                    children: Text(
                      'あそびかた',
                      style: TextStyle(
                        fontSize: AppSize.md,
                        color: AppColors.accentColor,
                      ),
                    ),
                    tapFunc: () {
                      context.go(AppRoutes.guide);
                    },
                  ),

                  /// TODO: 結果確認画面への遷移確認時に追加・完成時に削除
                  // CommonButton(
                  //   bgColor: AppColors.strawberryRed,
                  //   children: Text(
                  //     '結果確認画面へ',
                  //     style: TextStyle(color: AppColors.accentColor),
                  //   ),
                  //   tapFunc: () {
                  //     context.go(AppRoutes.result);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

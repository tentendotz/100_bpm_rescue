import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';

///
/// ゲームの結果画面
///
class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.countNum, this.spendTime = 60});

  final int countNum;
  final int spendTime;

  bool get _isFailed => spendTime != 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: AppSize.sm,
          vertical: AppSize.xs,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _isFailed ? 'ざんねん！' : 'よくできました！',
              style: TextStyle(
                fontSize: AppSize.resultTitleTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 2) - AppSize.lg,
              height: (MediaQuery.of(context).size.height / 2) - AppSize.xl,
              child: Image.asset(
                scale: 1.0,
                _isFailed
                    ? 'assets/images/chara/cat_failed.png'
                    : 'assets/images/chara/cat_success.png',
              ),
            ),
            Text('1分間に$countNum回', style: TextStyle(fontSize: AppSize.xm)),
            // TODO　「でもよくがんばりました！」ではなく、遅すぎる/早すぎるに変更できるようにする
            Text(
              _isFailed ? 'でもよくがんばりました！' : 'すばらしいです！',
              style: TextStyle(fontSize: AppSize.md),
            ),
            SizedBox(height: AppSize.sm),
            Row(
              spacing: AppSize.xxs,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonButton(
                  bgColor: AppColors.azureBlue,
                  children: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: AppSize.xxs,
                    children: [
                      Icon(Icons.replay_outlined, color: AppColors.accentColor),
                      Text(
                        'もう一回',
                        style: TextStyle(color: AppColors.accentColor),
                      ),
                    ],
                  ),
                  tapFunc: () {
                    context.go(AppRoutes.game);
                  },
                ),
                CommonButton(
                  bgColor: AppColors.accentColor,
                  children: Text(
                    'トップへ',
                    style: TextStyle(color: AppColors.deepSpaceBlue),
                  ),
                  tapFunc: () {
                    context.go(AppRoutes.top);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

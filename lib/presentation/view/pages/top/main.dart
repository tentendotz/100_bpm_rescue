import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/bottom_nav.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';
import 'package:hackathon_app/presentation/view/model/bottom_nav_item_model.dart';

///
/// トップ画面
///

class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentIndex = 0;
  final sampleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.aliceBlue, title: Text('タイトル')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSize.sm,
          children: <Widget>[
            const Text('ここから共通コンポーネントのサンプル'),
            CommonButton(
              children: Text(
                'ゲーム画面へ',
                style: TextStyle(color: AppColors.accentColor),
              ),
              tapFunc: () {
                context.go(AppRoutes.game);
              },
            ),
            CommonButton(
              bgColor: AppColors.strawberryRed,
              children: Text(
                '設定画面へ',
                style: TextStyle(color: AppColors.accentColor),
              ),
              tapFunc: () {
                context.go(AppRoutes.setting);
              },
            ),
            CommonButton(
              bgColor: AppColors.strawberryRed,
              children: Text(
                '結果画面へ',
                style: TextStyle(color: AppColors.accentColor),
              ),
              tapFunc: () {
                context.go(AppRoutes.result);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        itemList: [
          BottomNavItemModel(icon: Icon(Icons.home), labelText: 'Home'),
          BottomNavItemModel(icon: Icon(Icons.edit), labelText: 'Edit'),
          BottomNavItemModel(icon: Icon(Icons.settings), labelText: 'Setting'),
        ],
        tapFunc: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/presentation/view/pages/game/game_page.dart';
import 'package:hackathon_app/presentation/view/pages/ready/ready_page.dart';
import 'package:hackathon_app/presentation/view/pages/result/result_page.dart';
import 'package:hackathon_app/presentation/view/pages/setting/setting_page.dart';
import 'package:hackathon_app/presentation/view/pages/top/top_page.dart';

///
/// アプリの画面遷移を定義するクラス
///
abstract class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.top,
    routes: [
      GoRoute(
        path: AppRoutes.top,
        builder: (context, state) => const TopPage(),
      ),
      GoRoute(
        path: AppRoutes.ready,
        builder: (context, state) => const ReadyPage(),
      ),
      GoRoute(
        path: AppRoutes.game,
        builder: (context, state) => const GamePage(),
      ),
      GoRoute(
        path: AppRoutes.result,
        builder: (context, state) {
          // TODO　ゲーム画面から行った回数と計測時間を渡す
          // spendTimeはデフォルト値に60が入っているので必要な時だけ追加する
          final countNum = 100;
          return ResultPage(countNum: countNum);
        },
      ),
      GoRoute(
        path: AppRoutes.setting,
        builder: (context, state) => const SettingPage(),
      ),
    ],
  );
}

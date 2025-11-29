import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/presentation/view/pages/game/main.dart';
import 'package:hackathon_app/presentation/view/pages/result/main.dart';
import 'package:hackathon_app/presentation/view/pages/setting/main.dart';
import 'package:hackathon_app/presentation/view/pages/top/main.dart';

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
        path: AppRoutes.game,
        builder: (context, state) => const GamePage(),
      ),
      GoRoute(
        path: AppRoutes.result,
        builder: (context, state) => const ResultPage(),
      ),
      GoRoute(
        path: AppRoutes.setting,
        builder: (context, state) => const SettingPage(),
      ),
    ],
  );
}

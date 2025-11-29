import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
import 'package:hackathon_app/presentation/view_model/game/game_timer.dart';

///
/// ゲーム画面
///
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  final double optimalBpm = 120;

  @override
  Widget build(BuildContext context) {
    final CountdownManager countdownManager = CountdownManager(
      // TODO　↓extraの90に現在の押した回数を入れる
      onFinished: () => context.go(AppRoutes.result, extra: (60, 90)),
      // TODO　↓extraの100に現在の押した回数を入れる
      onForcedStop: (remainingSeconds) =>
          context.go(AppRoutes.result, extra: (remainingSeconds, 100)),
    );

    void gameStart() {
      countdownManager.start();
    }

    gameStart();

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // 左側: HeartbeatWave
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: HeartbeatWave(
                  bpm: optimalBpm,
                  waveColor: AppColors.azureBlue,
                ),
              ),
            ),
            // 右側: deepSpaceBlue色のボックス
            Expanded(
              child: Container(
                color: AppColors.deepSpaceBlue,
                child: const Center(
                  child: Text(
                    'ここに手をおいてね！',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

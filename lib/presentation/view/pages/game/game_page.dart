import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/routes/app_routes.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
import 'package:hackathon_app/presentation/view_model/game/game_timer.dart';
import 'package:hackathon_app/presentation/view_model/game/shake_manager.dart';

///
/// ゲーム画面
///
class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const double _optimalBpm = 120;
  late final ShakeManager _shakeManager;
  late final HeartbeatWaveController _heartbeatController;
  late final CountdownManager _countdownManager;

  @override
  void initState() {
    super.initState();
    _heartbeatController = HeartbeatWaveController();
    _shakeManager = ShakeManager(controller: _heartbeatController);

    // ゲーム開始（initStateで一度だけ呼ぶ）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _countdownManager = CountdownManager(
        // TODO　↓countNumに現在の押した回数を入れる
        onFinished: () => context.go(
          AppRoutes.result,
          extra: {'spendTime': 60, 'countNum': 90},
        ),
        // TODO　↓countNumに現在の押した回数を入れる
        onForcedStop: (remainingSeconds) => context.go(
          AppRoutes.result,
          extra: {'spendTime': remainingSeconds, 'countNum': 100},
        ),
      );
      _countdownManager.start();
      _shakeManager.gameStart();
    });
  }

  @override
  Future<void> dispose() async {
    await _shakeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // 左側: HeartbeatWave
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.sm),
                child: HeartbeatWave(
                  bpm: _optimalBpm,
                  waveColor: AppColors.azureBlue,
                  controller: _heartbeatController,
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
                      fontSize: AppSize.lg,
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

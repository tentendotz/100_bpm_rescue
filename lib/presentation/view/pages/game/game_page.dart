import 'package:flutter/material.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
///
/// ゲーム画面
///
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  final double optimalBpm = 120;

  @override
  Widget build(BuildContext context) {
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
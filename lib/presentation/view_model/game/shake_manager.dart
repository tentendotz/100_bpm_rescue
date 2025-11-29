import 'dart:async';

import 'package:hackathon_app/presentation/view/pages/game/components/heart_beat_wave.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

///
/// 押す動作を検知するクラス
///
class ShakeManager {
  bool _movingDown = false;
  final double _threshold = 2.0;
  StreamSubscription? _subscription;
  bool _isStarted = false;

  ShakeManager({required this.controller});
  final HeartbeatWaveController controller;

  void gameStart() {
    // 既に開始している場合は何もしない
    if (_isStarted) return;
    _isStarted = true;

    // ignore: deprecated_member_use
    _subscription = accelerometerEvents.listen((event) async {
      double z = event.z;

      // 下方向に動いた
      if (!_movingDown && z < -_threshold) {
        _movingDown = true;

        // 下方向に動いたときだけバイブ
        if (await Vibration.hasVibrator()) {
          // 短く強く震える
          await Vibration.vibrate(
            pattern: [0, 120, 60, 120],
            intensities: [255, 255],
          );
          controller.triggerPulse();
        }
      }

      // 上方向に戻ったらカウント
      if (_movingDown && z > _threshold) {
        _movingDown = false;
        controller.triggerPulse();
      }
    });
  }

  /// リソースを解放
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    _isStarted = false;
  }
}

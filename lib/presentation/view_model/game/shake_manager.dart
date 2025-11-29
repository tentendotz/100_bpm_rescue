import 'dart:async';
import 'dart:ui';

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
  bool _vibrated = false;

  ShakeManager({required this.controller, required this.successFunc});
  final HeartbeatWaveController controller;
  final VoidCallback successFunc;

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

        // 下方向に動いたときだけ1回バイブ
        if (!_vibrated && await Vibration.hasVibrator()) {
          _vibrated = true; // 一度振動したらフラグ立てる
          await Vibration.vibrate(
            duration: 50,
            amplitude: 255, // 強度をMAX（Android）
          );
          controller.triggerPulse();
        }
        successFunc();
      }

      // 上方向に戻ったらリセット
      if (_movingDown && z > _threshold) {
        _movingDown = false;
        _vibrated = false; // 上方向に戻ったら再び振動可能
      }
    });
  }

  // リソースを解放
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    _isStarted = false;
    _movingDown = false;
    _vibrated = false;
  }
}

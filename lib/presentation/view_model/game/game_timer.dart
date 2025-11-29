import 'dart:async';
import 'dart:ui';

///
/// 自動的に60秒経ったら結果画面に遷移する挙動のクラス
///
class CountdownManager {
  Timer? _timer;

  CountdownManager({required this.onFinished, required this.onForcedStop});

  final int initialDuration = 60;
  int _currentCount = 60;
  final VoidCallback onFinished;
  final Function(int remainingSeconds) onForcedStop;

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  //　ゲーム画面でのカウントダウンを開始するためのメソッド
  void start() {
    if (_timer != null && _timer!.isActive) return;
    _currentCount = initialDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentCount > 0) {
        _currentCount--;
      } else {
        dispose();
        onFinished();
      }
    });
  }

  //　20回連続で失敗したら強制的に送還するためのメソッド
  void stopAndFinish() {
    if (_timer != null && _timer!.isActive) {
      dispose();
      onForcedStop(_currentCount);
    }
  }
}

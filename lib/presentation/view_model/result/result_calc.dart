///
/// 結果画面用の行った心臓マッサージが早いか遅いかを判断するロジッククラス
///
class ResultCalc {
  ResultCalc({required this.timeInSeconds, required this.countNum});

  final int timeInSeconds;
  final int countNum;

  // 割合 = 回数 / 時間 (秒)
  double calculateRatePerSecond() {
    return countNum / timeInSeconds;
  }

  // 1分換算した場合の割合
  int calculateCountInSixtySeconds() {
    final rate = calculateRatePerSecond();
    final countForSixty = rate * 60.0;
    return countForSixty.round();
  }

  // 1分換算した場合、早すぎるか遅すぎるか計算
  String calcResultDetailToString() {
    final calcResultNum = calculateCountInSixtySeconds();
    if (calcResultNum < 100 || calcResultNum == 0) {
      return '遅すぎます…';
    } else if (calcResultNum > 120) {
      return '早すぎます…';
    }
    return 'すばらしいです！';
  }

  // 成功か失敗かで表示させる大項目テキストを変える
  String calcResultToString() {
    final calcResultNum = calculateCountInSixtySeconds();
    if (calcResultNum < 100 || calcResultNum > 120) {
      return 'ざんねん！';
    }
    return 'よくできました！';
  }

  // 成功か失敗かで表示させる画像を変える
  String calcResultImage() {
    final calcResultNum = calculateCountInSixtySeconds();
    if (calcResultNum < 100 || calcResultNum > 120) {
      return 'assets/images/chara/cat_failed.png';
    }
    return 'assets/images/chara/cat_success.png';
  }
}

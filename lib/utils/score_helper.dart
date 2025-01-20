class ScoreHelper {
  ScoreHelper._();

  static String scoreMessage(int score, int maxScore) {
    if (score > maxScore) {
      throw ArgumentError('Score is higher than maxScore.');
    }
    final rate = score / maxScore;
    if (score == maxScore) {
      return 'パーフェクト達成🎉';
    } else if (rate > 0.75) {
      return '素晴らしい👏';
    } else if (rate > 0.5) {
      return 'いい感じですね。';
    } else if (rate > 0.25) {
      return 'もっと勉強しましょう。';
    } else if (rate > 0) {
      return 'このままだと留年してしまいます。';
    }
    return '逆パーフェクト！逆にすごいです！';
  }
}

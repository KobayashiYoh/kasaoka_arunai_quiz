import 'package:kasaoka_arunai_quiz/models/quiz.dart';

class Constants {
  Constants._();

  static const List<Quiz> quizData = <Quiz>[
    Quiz(
      question: '笠岡にスタバはある？ない？',
      description: '笠岡に星乃珈琲はありますが、スタバはありません。',
      answer: false,
    ),
    Quiz(
      question: '笠岡にガストはある？ない？',
      description: '笠岡にジョイフルはありませんが、ガストはあります。',
      answer: true,
    ),
    Quiz(
      question: '笠岡に松屋はある？ない？',
      description: '笠岡に松屋はありませんが、西松屋はあります。',
      answer: false,
    ),
    Quiz(
      question: '笠岡にケーズデンキはある？ない？',
      description: '笠岡にエディオンはありますが、ケーズデンキはありません。',
      answer: false,
    ),
    Quiz(
      question: '笠岡に公立大学はある？ない？',
      description: 'そもそも笠岡に大学はありません。',
      answer: false,
    ),
    Quiz(
      question: '笠岡に駅の自動改札はある？ない？',
      description: '笠岡駅の改札には自動改札があり、きっぷを買わなくてもICカードで電車に乗車することができます。',
      answer: true,
    ),
    Quiz(
      question: '笠岡に中国自動車道のサービスエリアはある？ない？',
      description:
          'そもそも笠岡に中国自動車道は通っていません。山陽自動車道は通っていますが、あるのはサービスエリアではなく、パーキングエリアです。',
      answer: false,
    ),
    Quiz(
      question: '笠岡に隅田川はある？ない？',
      description: '驚くことに、笠岡には本当に隅田川という名前の川が流れています。',
      answer: true,
    ),
    Quiz(
      question: '笠岡にカブトガニ博物館はある？ない？',
      description: 'サービス問題ですね。笠岡には世界で唯一のカブトガニをテーマとした博物館があります。',
      answer: true,
    ),
    Quiz(
      question: '笠岡にゆめタウンはある？ない？',
      description:
          'ひっかけ問題です。ゆめタウンはお隣の広島県を中心に西日本の一部地域に店舗を展開するショッピングセンターですが、笠岡にはありません。',
      answer: false,
    ),
  ];
}

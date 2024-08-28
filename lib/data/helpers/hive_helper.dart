import 'package:hive_flutter/hive_flutter.dart';
import 'package:ojo/data/models/quiz_model.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("APP_BOX");
  }

  static late final Box _box;

  static List<Quiz> get quizzes {
    final resp = List.from(_box.get("quizzes") ?? []);
    final res = List<Map>.from(resp.map((e) => Map.from(e)))
        .map((e) => Quiz.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return res;
  }

  static bool get isDailyRewardAvailable {
    final resp = _box.get("last_reward_date");
    if (resp == null) return true;
    final result = DateTime.fromMillisecondsSinceEpoch(resp);
    final now = DateTime.now();
    ;
    final diff = now.difference(result).inDays;
    return diff >= 1;
  }

  static int get coins {
    return _box.get("coins") ?? 0;
  }

  static Future<void> saveQuiz(Quiz quiz) async {
    await _box.put(
        "quizzes", [...quizzes, quiz].map((e) => e.toMap()).toList());
  }

  static Future<void> receiveReward(int reward) async {
    await _box.put("last_reward_date", DateTime.now().millisecondsSinceEpoch);
    await _box.put("coins", coins + reward);
  }
}

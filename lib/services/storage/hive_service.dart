import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    // 可以在这里初始化具体的 Box
  }

  static Box? getBox(String boxName) {
    return Hive.box(boxName);
  }

  static Future<void> put(String boxName, String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  static dynamic get(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  static Future<void> delete(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }
}


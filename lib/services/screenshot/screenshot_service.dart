import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

/// ScreenshotService
///
/// 截图与保存逻辑集中在 Service，方便复用与替换实现。
class ScreenshotService {
  /// 截取 [controller] 当前内容并保存到应用文档目录。
  ///
  /// 返回保存的本地路径，失败时返回 null。
  static Future<String?> captureAndSave(ScreenshotController controller) async {
    try {
      final image = await controller.capture();
      if (image == null) {
        return null;
      }
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);
      return imagePath;
    } catch (_) {
      return null;
    }
  }
}



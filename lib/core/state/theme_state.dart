import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 全局主题 / 语言状态
///
/// 原本定义在 Demo 页里，这里提升到核心状态层，便于全局使用。
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// 当前语言代码（例如 'zh' / 'en'）
final languageProvider = StateProvider<String>((ref) => 'zh');



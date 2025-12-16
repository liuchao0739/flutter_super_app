import 'package:flutter/material.dart';

/// 应用本地化字符串
/// TODO(prod): 使用 flutter_localizations 和 intl 包生成完整的本地化支持
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // 通用
  String get appName => _getLocalizedValue('appName', 'SuperApp');
  String get ok => _getLocalizedValue('ok', '确定');
  String get cancel => _getLocalizedValue('cancel', '取消');
  String get confirm => _getLocalizedValue('confirm', '确认');
  String get retry => _getLocalizedValue('retry', '重试');
  String get loading => _getLocalizedValue('loading', '加载中...');
  String get noData => _getLocalizedValue('noData', '暂无数据');
  String get error => _getLocalizedValue('error', '错误');
  String get success => _getLocalizedValue('success', '成功');

  // 电商模块
  String get productList => _getLocalizedValue('productList', '商品列表');
  String get productDetail => _getLocalizedValue('productDetail', '商品详情');
  String get addToCart => _getLocalizedValue('addToCart', '加入购物车');
  String get buyNow => _getLocalizedValue('buyNow', '立即购买');
  String get cart => _getLocalizedValue('cart', '购物车');
  String get order => _getLocalizedValue('order', '订单');
  String get searchProduct => _getLocalizedValue('searchProduct', '搜索商品');
  String get filter => _getLocalizedValue('filter', '筛选');
  String get sort => _getLocalizedValue('sort', '排序');

  // IM 模块
  String get messages => _getLocalizedValue('messages', '消息');
  String get chat => _getLocalizedValue('chat', '聊天');
  String get sendMessage => _getLocalizedValue('sendMessage', '发送消息');

  // 视频模块
  String get video => _getLocalizedValue('video', '视频');
  String get live => _getLocalizedValue('live', '直播');
  String get like => _getLocalizedValue('like', '点赞');
  String get comment => _getLocalizedValue('comment', '评论');
  String get share => _getLocalizedValue('share', '分享');

  // 工具模块
  String get tools => _getLocalizedValue('tools', '工具');
  String get scan => _getLocalizedValue('scan', '扫码');
  String get scanResult => _getLocalizedValue('scanResult', '扫码结果');

  // 行业模块
  String get industry => _getLocalizedValue('industry', '行业');
  String get taskBoard => _getLocalizedValue('taskBoard', '任务看板');
  String get document => _getLocalizedValue('document', '文档');

  String _getLocalizedValue(String key, String defaultValue) {
    // TODO(prod): 从资源文件加载本地化字符串
    // 当前返回默认值（中文）
    if (locale.languageCode == 'en') {
      return _getEnglishValue(key, defaultValue);
    }
    return defaultValue;
  }

  String _getEnglishValue(String key, String defaultValue) {
    final enMap = {
      'appName': 'SuperApp',
      'ok': 'OK',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'retry': 'Retry',
      'loading': 'Loading...',
      'noData': 'No Data',
      'error': 'Error',
      'success': 'Success',
      'productList': 'Product List',
      'productDetail': 'Product Detail',
      'addToCart': 'Add to Cart',
      'buyNow': 'Buy Now',
      'cart': 'Cart',
      'order': 'Order',
      'searchProduct': 'Search Product',
      'filter': 'Filter',
      'sort': 'Sort',
      'messages': 'Messages',
      'chat': 'Chat',
      'sendMessage': 'Send Message',
      'video': 'Video',
      'live': 'Live',
      'like': 'Like',
      'comment': 'Comment',
      'share': 'Share',
      'tools': 'Tools',
      'scan': 'Scan',
      'scanResult': 'Scan Result',
      'industry': 'Industry',
      'taskBoard': 'Task Board',
      'document': 'Document',
    };
    return enMap[key] ?? defaultValue;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

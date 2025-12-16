import 'dart:async';

/// 简单全局事件总线，用于解耦模块间的通知。
///
/// - 支持按事件类型（String）广播
/// - 支持携带任意 payload
class AppEvent {
  final String type;
  final dynamic payload;

  AppEvent(this.type, [this.payload]);
}

class EventBus {
  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  factory EventBus() => _instance;

  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  StreamSubscription<AppEvent> on(String type, void Function(AppEvent) handler) {
    return _controller.stream
        .where((event) => event.type == type)
        .listen(handler);
  }

  void emit(String type, [dynamic payload]) {
    _controller.add(AppEvent(type, payload));
  }

  void dispose() {
    _controller.close();
  }
}



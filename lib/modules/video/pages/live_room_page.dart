import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/feed_video.dart';
import '../../../repositories/video_repository.dart';
import '../widgets/live_room_header.dart';
import '../widgets/danmaku_list.dart';
import '../widgets/danmaku_input_bar.dart';

/// 直播间页
class LiveRoomPage extends ConsumerStatefulWidget {
  final String roomId;

  const LiveRoomPage({Key? key, required this.roomId}) : super(key: key);

  @override
  ConsumerState<LiveRoomPage> createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends ConsumerState<LiveRoomPage> {
  final TextEditingController _danmakuController = TextEditingController();
  final ScrollController _danmakuScrollController = ScrollController();
  final List<DanmakuMessage> _danmakuMessages = [];
  final VideoRepository _repository = VideoRepository();

  @override
  void dispose() {
    _danmakuController.dispose();
    _danmakuScrollController.dispose();
    super.dispose();
  }

  Future<void> _sendDanmaku() async {
    final content = _danmakuController.text.trim();
    if (content.isEmpty) return;

    final message = await _repository.sendDanmaku(
      roomId: widget.roomId,
      userId: 'user_001',
      userName: '我',
      content: content,
    );

    setState(() {
      _danmakuMessages.add(message);
    });

    _danmakuController.clear();
    _scrollToBottom();
  }

  Future<void> _sendGift(String giftName) async {
    final message = await _repository.sendGift(
      roomId: widget.roomId,
      userId: 'user_001',
      userName: '我',
      giftName: giftName,
    );

    setState(() {
      _danmakuMessages.add(message);
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_danmakuScrollController.hasClients) {
        _danmakuScrollController.animateTo(
          _danmakuScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(
      FutureProvider((ref) async {
        final repository = VideoRepository();
        return await repository.getLiveRoomById(widget.roomId);
      }),
    );

    return Scaffold(
      body: roomAsync.when(
        data: (room) {
          if (room == null) {
            return const Center(child: Text('直播间不存在'));
          }

          return Stack(
            children: [
              // 直播流/封面
              Image.network(
                room.coverUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black,
                    child: const Center(
                      child: Icon(Icons.videocam_off, color: Colors.white),
                    ),
                  );
                },
              ),
              // 顶部信息栏
              LiveRoomHeader(room: room),
              // 弹幕列表
              Positioned(
                left: 16,
                top: 100,
                bottom: 120,
                child: Container(
                  width: 200,
                  child: DanmakuList(
                    messages: _danmakuMessages,
                    scrollController: _danmakuScrollController,
                  ),
                ),
              ),
              // 底部输入栏和礼物
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: DanmakuInputBar(
                  controller: _danmakuController,
                  onSend: _sendDanmaku,
                  onGiftSelected: _sendGift,
                ),
              ),
            ],
          );
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          body: Center(child: Text('加载失败: $error')),
        ),
      ),
    );
  }
}


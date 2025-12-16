import 'package:flutter/material.dart';
import '../../../models/feed_video.dart';

/// 视频卡片组件
class VideoCard extends StatefulWidget {
  final FeedVideo video;
  final bool isCurrent;
  final VoidCallback onLike;

  const VideoCard({
    Key? key,
    required this.video,
    required this.isCurrent,
    required this.onLike,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.video.isLiked;
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!_isLiked) {
      setState(() => _isLiked = true);
      _likeAnimationController.forward().then((_) {
        _likeAnimationController.reverse();
      });
      widget.onLike();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 视频封面/播放器
          Image.network(
            widget.video.coverUrl,
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
          // 双击点赞动画
          Center(
            child: AnimatedBuilder(
              animation: _likeAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _likeAnimation.value,
                  child: Opacity(
                    opacity: _likeAnimationController.isAnimating ? 1.0 : 0.0,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 80,
                    ),
                  ),
                );
              },
            ),
          ),
          // 右侧操作栏
          Positioned(
            right: 16,
            bottom: 80,
            child: Column(
              children: [
                VideoActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  label: _formatCount(widget.video.likeCount + (_isLiked ? 1 : 0)),
                  color: _isLiked ? Colors.red : Colors.white,
                  onTap: () {
                    setState(() => _isLiked = !_isLiked);
                    widget.onLike();
                  },
                ),
                const SizedBox(height: 24),
                VideoActionButton(
                  icon: Icons.comment_outlined,
                  label: _formatCount(widget.video.commentCount),
                  onTap: () {
                    // TODO: 打开评论
                  },
                ),
                const SizedBox(height: 24),
                VideoActionButton(
                  icon: Icons.share_outlined,
                  label: _formatCount(widget.video.shareCount),
                  onTap: () {
                    // TODO: 分享
                  },
                ),
              ],
            ),
          ),
          // 底部信息
          Positioned(
            left: 16,
            bottom: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 作者信息
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.video.authorAvatar != null
                          ? NetworkImage(widget.video.authorAvatar!)
                          : null,
                      child: widget.video.authorAvatar == null
                          ? Text(
                              widget.video.authorName.isNotEmpty
                                  ? widget.video.authorName[0]
                                  : '?',
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.video.authorName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: 关注
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('关注'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 视频标题
                Text(
                  widget.video.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // 标签
                if (widget.video.tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: widget.video.tags.take(3).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '#$tag',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 10000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return '${(count / 10000).toStringAsFixed(1)}w';
    }
  }
}

/// 视频操作按钮组件
class VideoActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const VideoActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color ?? Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}


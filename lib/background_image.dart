import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/page_offset_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class BackgroundImage extends StatelessWidget {
  final int id;
  final BackgroundItem backgroundItem;
  final double verticalOffset;
  final double speed;
  final double horizontalOffset;
  final bool centerBackground;

  BackgroundImage({
    required this.id,
    required this.speed,
    required this.backgroundItem,
    required this.verticalOffset,
    required this.centerBackground,
    required this.horizontalOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Stack(children: [
          Positioned(
            top: verticalOffset,
            left: MediaQuery.of(context).size.width * ((id - 1) * speed) -
                speed * notifier.offset +
                (centerBackground ? 0 : horizontalOffset),
            child: centerBackground
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: child!,
                  )
                : child!,
          ),
        ]);
      },
      child: backgroundItem.type == BackgroundType.image
          ? Image.asset(
              backgroundItem.assetPath,
              fit: BoxFit.cover,
            )
          : _VideoBackground(
              videoAssetPath: backgroundItem.assetPath,
            ),
    );
  }
}

class _VideoBackground extends StatefulWidget {
  final String videoAssetPath;

  const _VideoBackground({required this.videoAssetPath});

  @override
  __VideoBackgroundState createState() => __VideoBackgroundState();
}

class __VideoBackgroundState extends State<_VideoBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container();
  }
}

enum BackgroundType { image, video }

class BackgroundItem {
  final BackgroundType type;
  final String assetPath;

  BackgroundItem({required this.type, required this.assetPath});
}

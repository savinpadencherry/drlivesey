// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:carousel/core/logger.dart';
import 'package:flutter/material.dart';

import 'package:carousel/core/models/media.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CarouselWidgetImage extends StatefulWidget {
  final MediaFiles? mediaModel;
  const CarouselWidgetImage({
    Key? key,
    this.mediaModel,
  }) : super(key: key);

  @override
  State<CarouselWidgetImage> createState() => _CarouselWidgetImageState();
}

class _CarouselWidgetImageState extends State<CarouselWidgetImage>
    with TickerProviderStateMixin, LogMixin {
  VideoPlayerController? _videoPlayerController;
  bool _showTextAnimation = false;
  @override
  void initState() {
    if (widget.mediaModel!.type == "video") {
      _videoPlayerController =
          VideoPlayerController.network(widget.mediaModel!.mediaUrl)
            ..initialize().then((value) {
              setState(() {});
            });
      _videoPlayerController!.play();
      _videoPlayerController!.setLooping(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.pause();
    _videoPlayerController!.dispose();
    super.dispose();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(getRandomString(5)),
      onVisibilityChanged: (info) {
        var visiblePercentage = info.visibleFraction * 100;
        infoLog('$visiblePercentage');
        if (visiblePercentage < 100) {
          //_controller.reset();
          setState(() {
            _showTextAnimation = false;
          });
          infoLog('$_showTextAnimation');
          if (_videoPlayerController != null ||
              widget.mediaModel!.type == 'image') {
            _videoPlayerController?.pause();
          }
        } else if (_videoPlayerController != null ||
            widget.mediaModel!.type == 'video') {
          _videoPlayerController?.play();
          setState(() {
            _showTextAnimation = true;
          });
          warningLog('$visiblePercentage');
        } else if (visiblePercentage == 100) {
          setState(() {
            _showTextAnimation = true;
          });
          infoLog('$_showTextAnimation');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: widget.mediaModel!.type == 'video'
                      ? VideoPlayer(_videoPlayerController!)
                      : Image.network(
                          widget.mediaModel!.mediaUrl,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: _showTextAnimation ? 1 : 0,
                curve: Curves.easeInCubic,
                child: Text(
                  widget.mediaModel!.title,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

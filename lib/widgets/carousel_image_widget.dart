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
  late AnimationController _controller;
  late Animation<Offset> _size;
  bool _showTextAnimation = false;
  bool _shownAnimationOnceWhen100 = false;
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
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
      _size = Tween<Offset>(
        begin: const Offset(0.0, 3.0),
        end: const Offset(0.0, 0.0),
      ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
        ..addListener(() {
          setState(() {});
        });
      _size.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          warningLog('$status');
          _controller.reset();
        }
      });
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _size = Tween<Offset>(
      begin: const Offset(0.0, 3.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    _size.addStatusListener((status) {
      warningLog('$status');
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.pause();
    _videoPlayerController!.dispose();
    _controller.dispose();
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

        if (visiblePercentage < 100) {
          _controller.reverse();
          setState(() {
            _showTextAnimation = false;
            _shownAnimationOnceWhen100 = false;
          });
          infoLog('$_showTextAnimation');
          if (_videoPlayerController != null ||
              widget.mediaModel!.type == 'image') {
            _videoPlayerController?.pause();
            _controller.reverse();
          }
        } else if (_videoPlayerController != null ||
            widget.mediaModel!.type == 'video') {
          _videoPlayerController?.play();
          _controller.forward();
          setState(() {
            _showTextAnimation = true;
          });
          warningLog('$visiblePercentage');
        } else if (visiblePercentage == 100) {
          _shownAnimationOnceWhen100 == true ? null : _controller.forward();
          setState(() {
            _showTextAnimation = true;
            _shownAnimationOnceWhen100 = true;
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
              SlideTransition(
                position: _size,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 5),
                  opacity: _showTextAnimation ? 1 : 0.5,
                  curve: Curves.easeIn,
                  child: Text(
                    widget.mediaModel!.title,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

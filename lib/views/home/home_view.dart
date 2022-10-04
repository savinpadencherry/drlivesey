library home_view;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel/core/locator.dart';
import 'package:carousel/core/logger.dart';
import 'package:carousel/core/models/media.dart';
import 'package:carousel/core/repositories/datarepository.dart';
import 'package:carousel/widgets/carousel_image_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: const _HomeMobile(),
        desktop: const _HomeDesktop(),
        tablet: const _HomeTablet(),
      );
    });
  }
}

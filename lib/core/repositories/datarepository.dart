import 'dart:convert';

import 'package:carousel/core/logger.dart';
import 'package:carousel/core/models/media.dart';
import 'package:carousel/widgets/carousel_image_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class DataRepository with LogMixin {
  List<CarouselWidgetImage> widgets = [];
  Future<List<CarouselWidgetImage>> getVideoData() async {
    final url = Uri.parse('https://smashingpixels.io/api/slides');
    try {
      final response = await http.get(url);
      warningLog('$response');
      final responseBody =
          json.decode(response.body)['slides'] as List<dynamic>;
      warningLog('$responseBody');
      List<MediaFiles> mediaFileModels =
          responseBody.map((element) => MediaFiles.fromMap(element)).toList();
      warningLog('$mediaFileModels');
      for (var mediaModel in mediaFileModels) {
        widgets.add(
          CarouselWidgetImage(
            mediaModel: mediaModel,
          ),
        );
        warningLog('Checking for widgets$widgets');
      }
      return widgets;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MediaFiles>> getVideoDataModels() async {
    final url = Uri.parse('https://smashingpixels.io/api/slides');
    try {
      final response = await http.get(url);
      warningLog('$response');
      final responseBody =
          json.decode(response.body)['slides'] as List<dynamic>;
      warningLog('$responseBody');
      List<MediaFiles> mediaFileModels =
          responseBody.map((element) => MediaFiles.fromMap(element)).toList();
      warningLog('$mediaFileModels');
      return mediaFileModels;
    } catch (e) {
      rethrow;
    }
  }
}

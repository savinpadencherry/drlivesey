// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MediaFiles extends Equatable {
  final String type;
  final String title;
  final String mediaUrl;
  const MediaFiles({
    required this.type,
    required this.title,
    required this.mediaUrl,
  });

  MediaFiles copyWith({
    String? type,
    String? title,
    String? mediaUrl,
  }) {
    return MediaFiles(
      type: type ?? this.type,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
      'mediaUrl': mediaUrl,
    };
  }

  factory MediaFiles.fromMap(Map<String, dynamic> map) {
    return MediaFiles(
      type: map['type'] as String,
      title: map['title'] as String,
      mediaUrl: map['mediaUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaFiles.fromJson(String source) =>
      MediaFiles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, title, mediaUrl];
}

import 'package:lanternchat/models/messages/thumbnail.dart';

class _Field {
  static const String url = 'url';
  static const String thumbnail = 'thumbnail';
  static const String fileSize = 'fileSize';
  static const String mimeType = 'mimeType';
}

class MessageMedia {
  final String url;
  final Thumbnail? thumbnail;
  final int? fileSize;
  final String? mimeType;

  MessageMedia({required this.url, this.thumbnail, this.fileSize, this.mimeType});

  Map<String, dynamic> toMap() {
    return {
      _Field.url: url,
      _Field.thumbnail: thumbnail?.toMap(),
      _Field.fileSize: fileSize,
      _Field.mimeType: mimeType,
    };
  }

  factory MessageMedia.fromMap(Map<String, dynamic> map) {
    final thumbnailMap = map[_Field.thumbnail] as Map<String, dynamic>?;
    return MessageMedia(
      url: map[_Field.url] ?? '',
      thumbnail: thumbnailMap != null ? Thumbnail.fromMap(thumbnailMap) : null,
      fileSize: map[_Field.fileSize]?.toInt(),
      mimeType: map[_Field.mimeType],
    );
  }
}

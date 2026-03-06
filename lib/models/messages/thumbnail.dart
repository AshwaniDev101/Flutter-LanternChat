class _Field {
  static const String width = 'width';
  static const String height = 'height';
  static const String url = 'url';
}

class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail({required this.url, required this.width, required this.height});

  Map<String, dynamic> toMap() {
    return {_Field.url: url, _Field.width: width, _Field.height: height};
  }

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      url: map[_Field.url] ?? '',
      width: (map[_Field.width] ?? 0).toInt(),
      height: (map[_Field.height] ?? 0).toInt(),
    );
  }
}

class _Field {
  static const String name = 'name';
  static const String imageUrl = 'imageUrl';
  static const String description = 'description';
  static const String createdBy = 'createdBy';
}

class GroupInfo {
  final String name;
  final String imageUrl;
  final String description;
  final String createdBy;

  GroupInfo({required this.name, required this.imageUrl, required this.description, required this.createdBy});

  Map<String, dynamic> toMap() {
    return {_Field.name: name, _Field.imageUrl: imageUrl, _Field.description: description, _Field.createdBy: createdBy};
  }

  factory GroupInfo.fromMap(Map<String, dynamic> map) {
    return GroupInfo(
      name: map[_Field.name] ?? '',
      imageUrl: map[_Field.imageUrl] ?? '',
      description: map[_Field.description] ?? '',
      createdBy: map[_Field.createdBy] ?? '',
    );
  }
}

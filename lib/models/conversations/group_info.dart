import '../users/app_user.dart';

class _Field {
  static const String name = 'name';
  static const String imageUrl = 'imageUrl';
  static const String description = 'description';
  static const String createdBy = 'createdBy';
}

class GroupInfo {
  final String title;
  final String imageUrl;
  final String description;
  final AppUser createdBy;

  GroupInfo({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.name: title,
      _Field.imageUrl: imageUrl,
      _Field.description: description,
      _Field.createdBy: createdBy.toMap(),
    };
  }

  factory GroupInfo.fromMap(Map<String, dynamic> map) {
    return GroupInfo(
      title: map[_Field.name] ?? '',
      imageUrl: map[_Field.imageUrl] ?? '',
      description: map[_Field.description] ?? '',
      createdBy: AppUser.fromMap(map[_Field.createdBy]),
    );
  }

  GroupInfo copyWith({
    String? name,
    String? imageUrl,
    String? description,
    AppUser? createdBy,
    Set<String>? selectedContactIds,
  }) {
    return GroupInfo(
      title: name ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
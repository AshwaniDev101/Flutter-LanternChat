import '../users/app_user.dart';

class _Field {
  static const String name = 'name';
  static const String imageUrl = 'imageUrl';
  static const String description = 'description';
  static const String createdBy = 'createdBy';
  static const String selectedContactIds = 'selectedContactIds';
}

class GroupInfo {
  final String name;
  final String imageUrl;
  final String description;
  final AppUser createdBy;
  final Set<String> selectedContactIds;

  GroupInfo({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.createdBy,
    required this.selectedContactIds,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.name: name,
      _Field.imageUrl: imageUrl,
      _Field.description: description,
      _Field.createdBy: createdBy,
      _Field.selectedContactIds: selectedContactIds.toList(), // Firestore needs List
    };
  }

  factory GroupInfo.fromMap(Map<String, dynamic> map) {
    return GroupInfo(
      name: map[_Field.name] ?? '',
      imageUrl: map[_Field.imageUrl] ?? '',
      description: map[_Field.description] ?? '',
      createdBy: map[_Field.createdBy] ?? '',
      selectedContactIds: Set<String>.from(map[_Field.selectedContactIds] ?? []),
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
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      selectedContactIds: selectedContactIds ?? this.selectedContactIds,
    );
  }
}
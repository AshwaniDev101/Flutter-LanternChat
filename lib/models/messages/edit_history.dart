import 'package:cloud_firestore/cloud_firestore.dart';

class _Field {
  // EditHistory
  static const String previewText = 'previousText';
  static const String editedBy = 'editedBy';
  static const String editedAt = 'editedAt';
}

class EditHistory {
  final String previousText;
  final Timestamp editedAt;
  final String editedBy;

  EditHistory({required this.previousText, required this.editedAt, required this.editedBy});

  Map<String, dynamic> toMap() {
    return {_Field.previewText: previousText, _Field.editedAt: editedAt, _Field.editedBy: editedBy};
  }

  factory EditHistory.fromMap(Map<String, dynamic> map) {
    return EditHistory(
      previousText: map[_Field.previewText] ?? '',
      editedAt: map[_Field.editedAt] ?? Timestamp.now(),
      editedBy: map[_Field.editedBy] ?? '',
    );
  }
}

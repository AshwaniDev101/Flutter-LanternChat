class _Field {
  static const String uid = 'uid';
  static const String conversationId = 'conversationId';
  static const String name = 'name';
  static const String email = 'email';
  static const String photoURL = 'photoURL';
  static const String note = 'note';
}

class Contact {
  final String uid;
  final String conversationId;
  final String name;
  final String email;
  final String photoURL;
  final String? note;

  // empty contact is required by qr code scanner
  static const empty = Contact(uid: '', conversationId: '', name: '', email: '', photoURL: '');

  const Contact({
    required this.uid,
    required this.conversationId,
    required this.name,
    required this.email,
    required this.photoURL,
    this.note,
  });

  // Check if this contact is not empty
  bool isNotEmpty() {
    return uid.isNotEmpty || conversationId.isNotEmpty || name.isNotEmpty || email.isNotEmpty || photoURL.isNotEmpty;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      uid: map[_Field.uid] as String? ?? '',
      conversationId: map[_Field.conversationId] as String? ?? '',
      name: map[_Field.name] as String? ?? '',
      email: map[_Field.email] as String? ?? '',
      photoURL: map[_Field.photoURL] as String? ?? '',
      note: map[_Field.note] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.uid: uid,
      _Field.conversationId: conversationId,
      _Field.name: name,
      _Field.email: email,
      _Field.photoURL: photoURL,
      if (note != null) _Field.note: note,
    };
  }
}

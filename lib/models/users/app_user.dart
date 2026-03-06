import 'package:firebase_auth/firebase_auth.dart';

class _Field {
  static const String uid = 'uid';
  static const String conversationId = 'conversationId';
  static const String name = 'name';
  static const String email = 'email';
  static const String photoURL = 'photoURL';
}

class AppUser {
  final String uid;
  final String conversationId;
  final String name;
  final String email;
  final String photoURL;

  AppUser({
    required this.uid,
    required this.conversationId,
    required this.name,
    required this.email,
    required this.photoURL,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: map[_Field.uid] as String,
      conversationId: map[_Field.conversationId] as String,
      name: map[_Field.name] as String,
      email: map[_Field.email] as String,
      photoURL: map[_Field.photoURL] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.uid: uid,
      _Field.conversationId: conversationId,
      _Field.name: name,
      _Field.email: email,
      _Field.photoURL: photoURL,
    };
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid.toString(),
      conversationId: '',
      name: user.displayName.toString(),
      email: user.email.toString(),
      photoURL: user.photoURL.toString(),
    );
  }
}

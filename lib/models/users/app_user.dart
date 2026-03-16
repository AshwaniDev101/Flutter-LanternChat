import 'package:firebase_auth/firebase_auth.dart';
import 'package:lanternchat/models/users/contact.dart';

class _Field {
  static const String uid = 'uid';
  static const String name = 'name';
  static const String email = 'email';
  static const String photoURL = 'photoURL';
}

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String photoURL;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
  });

  // Todo map already have uid, think how you wanna handle this
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map[_Field.uid] as String,
      name: map[_Field.name] as String,
      email: map[_Field.email] as String,
      photoURL: map[_Field.photoURL] as String,
    );
  }

  Contact toContact() {
    return Contact(
      uid: uid,
      name: name,
      email: email,
      photoURL: photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.uid: uid,
      _Field.name: name,
      _Field.email: email,
      _Field.photoURL: photoURL,
    };
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      photoURL: user.photoURL.toString(),
    );
  }


}

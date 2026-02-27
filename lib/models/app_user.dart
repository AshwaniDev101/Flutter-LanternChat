import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String photoURL;

  AppUser({required this.uid, required this.name, required this.email, required this.photoURL});

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'photoURL': photoURL};
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid.toString(),
      name: user.displayName.toString(),
      email: user.email.toString(),
      photoURL: user.photoURL.toString(),
    );

  }
}

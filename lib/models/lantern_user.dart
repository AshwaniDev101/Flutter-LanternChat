

import 'package:cloud_firestore/cloud_firestore.dart';

class LanternUser {

  final String uid;
  final Timestamp lastOnline;
  final String email;
  final int version = 0;
  final String imageUrl;



  LanternUser({required this.uid, required this.lastOnline, required this.email, required this.imageUrl});


}
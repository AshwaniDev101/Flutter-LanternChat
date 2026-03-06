import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/users/app_user.dart';




class ContactService {
  final FirebaseFirestore firestore;

  late final userRef = firestore.collection('users');

  ContactService({required this.firestore});

  Stream<List<AppUser>> getConnections(String uid) {
    final connectionRef = userRef.doc(uid).collection('contact');

    // Stream<A>  →  Stream<B>
    //  Converting  'Stream<QuerySnapshot<Map<String, dynamic>>>'
    //  into-stream 'Stream<List<Map<String, dynamic>>>'
    return connectionRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // List<QueryDocumentSnapshot>   ->   List<AppUser>
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {

        // print("==== ${document.data().toString()}");
        return AppUser.fromMap(document.id,document.data());
      }).toList();
    });
  }
}

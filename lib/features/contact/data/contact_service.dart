import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/users/app_user.dart';
import 'package:lanternchat/models/users/contact.dart';

class _Field {
  static const String users = 'users';
  static const String contact = 'conversationsType';
}

class ContactService {
  final FirebaseFirestore firestore;

  late final userRef = firestore.collection(_Field.users);

  ContactService({required this.firestore});

  Stream<List<AppUser>> getContacts({required String uid}) {
    final connectionRef = userRef.doc(uid).collection(_Field.contact);

    // Stream<A>  →  Stream<B>
    //  Converting  'Stream<QuerySnapshot<Map<String, dynamic>>>'
    //  into-stream 'Stream<List<Map<String, dynamic>>>'
    return connectionRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // List<QueryDocumentSnapshot>   ->   List<AppUser>
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        // print("==== ${document.data().toString()}");
        return AppUser.fromMap(document.id, document.data());
      }).toList();
    });
  }

  void addContact({required String uid, required Contact contact}) {
    final ref = userRef.doc(uid).collection(_Field.contact);

    ref.doc(contact.uid).set(contact.toMap());
  }

  Future<Contact?> fetchUser(String uid) async {
    try {
      final snapshot = await userRef.doc(uid).get();

      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      return Contact.fromMap(data);
    } catch (e) {
      print("Error Could not get User $e");
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/users/contact.dart';

class _Field {
  static const String users = 'users';
  static const String contact = 'contacts';
  static const String conversationId = 'conversationId'; // make sure this String match class 'Contact' 'conversationId'
}

class ContactService {
  final FirebaseFirestore firestore;

  late final userRef = firestore.collection(_Field.users);

  ContactService({required this.firestore});

  Stream<List<Contact>> getContacts({required String uid}) {
    final connectionRef = userRef.doc(uid).collection(_Field.contact);

    // Stream<A>  →  Stream<B>
    //  Converting  'Stream<QuerySnapshot<Map<String, dynamic>>>'
    //  into-stream 'Stream<List<Map<String, dynamic>>>'
    return connectionRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // List<QueryDocumentSnapshot>   ->   List<AppUser>
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        // print("==== ${document.data().toString()}");
        return Contact.fromMap(document.data());
      }).toList();
    });
  }

  Future<void> addContact({required Contact thisContact, required Contact newContact}) async {
    final batch = firestore.batch();

    final conversationId = firestore.collection('conversations').doc().id;
    // This Contact list Operation
    // Stores new users contact to my own Contact list
    final thisUserContactRef = userRef.doc(thisContact.uid).collection(_Field.contact);
    // Extracting Map of new Contact
    final newContactMap = newContact.toMap();
    // Adding 'conversationId' to new contact map
    newContactMap[_Field.conversationId] = conversationId;
    // Storing the new contact in my own contact list
    batch.set(thisUserContactRef.doc(newContact.uid), newContactMap);

    // New Contact list Operation
    // Stores my contact on New users contact list
    final newUserContactRef = userRef.doc(newContact.uid).collection(_Field.contact);
    // Extracting my own Contact map
    final thisContactMap = thisContact.toMap();
    //  Adding 'conversationId' to my contact map
    thisContactMap[_Field.conversationId] = conversationId;
    // Storing my contact in new users contact list
    batch.set(newUserContactRef.doc(thisContact.uid), thisContactMap);

    await batch.commit();
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

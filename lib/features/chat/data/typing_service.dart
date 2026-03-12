import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class TypingService {
  final FirebaseDatabase firebaseDatabase;

  TypingService(this.firebaseDatabase);

  void sendData(Timestamp timestamp) {
    firebaseDatabase.ref().child('cake').child('sweet').set({'hello word': ServerValue.timestamp});
  }



  Stream<DatabaseEvent> watchData() {
    final ref = firebaseDatabase.ref().child('cake').child('sweet');


     return ref.onValue;
    // ref.onValue.listen((event) {
    //   final data = event.snapshot.value;
    //   print('#### ${data.toString()}');
    // });
  }
}

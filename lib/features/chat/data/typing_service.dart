import 'package:firebase_database/firebase_database.dart';

class TypingService {
  final FirebaseDatabase firebaseDatabase;

  TypingService(this.firebaseDatabase);



  void sendData()
  {
    firebaseDatabase.ref().child('cake').child('sweet').set({'hello':'word'});
  }
}

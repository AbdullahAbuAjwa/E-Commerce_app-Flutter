import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

dynamic data;

Future<dynamic> getUserData() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();

  final DocumentReference document =
      Firestore.instance.collection("users").document(firebaseUser.uid);

  await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
    data = snapshot.data;
  });
}



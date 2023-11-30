import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  Stream<QuerySnapshot> productos(){
    return FirebaseFirestore.instance.collection('productos').snapshots();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> Productos(){
    return FirebaseFirestore.instance.collection('productos').snapshots();
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> Categorias(){
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }
}
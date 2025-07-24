import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference subjects = FirebaseFirestore.instance.collection('subjects');

  Future<void> addSubject(String name, String code) async {
    await subjects.add({
      'name': name,
      'code': code,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

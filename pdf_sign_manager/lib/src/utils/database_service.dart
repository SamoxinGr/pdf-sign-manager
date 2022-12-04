import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/UserClass.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<UserClass>> retrieveData(String coll_name) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(
        coll_name).get();
    return snapshot.docs
        .map((docSnapshot) => UserClass.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
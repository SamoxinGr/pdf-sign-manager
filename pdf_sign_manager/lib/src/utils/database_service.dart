import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/TaskClass.dart';
import '../models/UserClass.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // USER
  addUser(UserClass userData, String coll_name) async {
    await _db.collection(coll_name).add(userData.toMap());
  }

  updateUser(UserClass userData, String coll_name) async {
    await _db.collection(coll_name).doc(userData.id).update(userData.toMap());
  }

  Future<List<UserClass>> retrieveUserData(String coll_name) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(
        coll_name).get();
    return snapshot.docs
        .map((docSnapshot) => UserClass.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  getUser(String? userEmail, String coll_name) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(coll_name).where("email", isEqualTo: userEmail).get();
    return snapshot.docs.map((docSnapshot) => UserClass.fromDocumentSnapshot(docSnapshot)).single;
  }

  //TASK
  addTask(TaskClass userData, String coll_name) async {
    await _db.collection(coll_name).add(userData.toMap());
  }

  updateTask(TaskClass userData, String coll_name) async {
    await _db.collection(coll_name).doc(userData.id).update(userData.toMap());
  }

  Future<List<TaskClass>> retrieveTaskData(String coll_name, String? to) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(coll_name).where("to", isEqualTo: to).get();
    return snapshot.docs.map((docSnapshot) => TaskClass.fromDocumentSnapshot(docSnapshot)).toList();
  }



}
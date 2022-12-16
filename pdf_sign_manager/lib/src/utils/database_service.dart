import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/TaskClass.dart';
import '../models/UserClass.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // USER
  addUser(String collName, String email, String job, String name) async {
    final data = <String, dynamic>{
      "email": email,
      "job": job,
      "name": name,
    };
    await _db.collection(collName).doc(name).set(data);
  }

  updateUser(UserClass userData, String collName) async {
    await _db.collection(collName).doc(userData.id).update(userData.toMap());
  }

  Future<List<UserClass>> retrieveUserData(String collName) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(
        collName).get();
    return snapshot.docs
        .map((docSnapshot) => UserClass.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  getUser(String? userEmail, String collName) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(collName).where("email", isEqualTo: userEmail).get();
    return snapshot.docs.map((docSnapshot) => UserClass.fromDocumentSnapshot(docSnapshot)).single;
  }

  //TASK

  updateTask(String collName, String? id, String? customer, String? description, String? from, String status, String? to) async {
    final data = <String, dynamic>{
      "customer": customer,
      "description": description,
      "from": from,
      "status": status,
      "to": to,
    };
    await _db.collection(collName).doc(id).update(data);
  }

  Future<List<TaskClass>> retrieveTaskData(String collName, String? to, String status) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(collName).where("to", isEqualTo: to).where("status", isEqualTo: status).get();
    return snapshot.docs.map((docSnapshot) => TaskClass.fromDocumentSnapshot(docSnapshot)).toList();
  }

  Future<List<TaskClass>> retrieveDoneTaskData(String collName, String? customer, String status) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection(collName).where("status", isNotEqualTo: status).where("customer", isEqualTo: customer).orderBy("status", descending: true).get();
    return snapshot.docs.map((docSnapshot) => TaskClass.fromDocumentSnapshot(docSnapshot)).toList();
  }

  addTask(String collName, String? customer, String description, String? from, String status, String to) async {
    final data = <String, dynamic>{
      "customer": customer,
      "description": description,
      "from": from,
      "status": status,
      "to": to,
    };
    await _db.collection(collName).add(data);
  }

}
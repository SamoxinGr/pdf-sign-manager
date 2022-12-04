import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {
  final String? id;
  final String? name;
  final String? job;


  UserClass({
    this.id,
    this.name,
    this.job,
  });

  UserClass.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
      name = doc.data()!["name"],
      job = doc.data()!["job"];
      //regions: data?['regions'] is Iterable ? List.from(data?['regions']) : null,

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (job != null) "job": job,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'job': job,
      //'address': address.toMap(),
    };
  }
}
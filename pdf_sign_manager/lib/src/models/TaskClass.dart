import 'package:cloud_firestore/cloud_firestore.dart';

class TaskClass {
  final String? id;
  final String? customer;
  final String? description;
  final String? from;
  final String? status;
  final String? to;


  TaskClass({
    this.id,
    this.customer,
    this.description,
    this.from,
    this.status,
    this.to,
  });

  TaskClass.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        customer = doc.data()!["customer"],
        description = doc.data()!["description"],
        from = doc.data()!["from"],
        status = doc.data()!["status"],
        to = doc.data()!["to"];
  //regions: data?['regions'] is Iterable ? List.from(data?['regions']) : null,

  Map<String, dynamic> toFirestore() {
    return {
      if (customer != null) "customer": customer,
      if (description != null) "description": description,
      if (from != null) "from": from,
      if (status != null) "status": status,
      if (to != null) "to": to
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'description': description,
      'from': from,
      'status': status,
      'to': to
      //'address': address.toMap(),
    };
  }
}
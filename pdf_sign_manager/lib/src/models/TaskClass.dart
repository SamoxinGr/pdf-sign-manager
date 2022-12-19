import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskClass {
  final String? id;
  final String? customer;
  final String? description;
  final String? from;
  final String? status;
  final String? to;
  final String? filename;


  TaskClass({
    this.id,
    this.customer,
    this.description,
    this.from,
    this.status,
    this.to,
    this.filename,
  });

  TaskClass.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        customer = doc.data()!["customer"],
        description = doc.data()!["description"],
        from = doc.data()!["from"],
        status = doc.data()!["status"],
        to = doc.data()!["to"],
        filename = doc.data()!["filename"];

  Map<String, dynamic> toFirestore() {
    return {
      if (customer != null) "customer": customer,
      if (description != null) "description": description,
      if (from != null) "from": from,
      if (status != null) "status": status,
      if (to != null) "to": to,
      if (filename != null) "filename": filename,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'description': description,
      'from': from,
      'status': status,
      'to': to,
      'filename': filename,
      //'address': address.toMap(),
    };
  }
}
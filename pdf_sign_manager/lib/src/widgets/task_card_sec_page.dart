import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/second_page/cubit/second_page_cubit.dart';

import '../models/TaskClass.dart';
import '../models/UserClass.dart';

Widget taskSecCard(
    TaskClass item, BuildContext context, SecondLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  String stat = item.status.toString();
  return item.status == "done" ? Card(
    color: Color.fromRGBO(254, 233, 225, 1),
    elevation: 2,
    margin: EdgeInsets.all(8),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Color.fromRGBO(254, 233, 225, 1),
      ),
      height: height / 8,
      child: Center(
        child: ListTile(
          leading: Icon(Icons.check),
          iconColor: Colors.green,
          title: Text(
            "${item.description}",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            "${item.status}",
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ),
  )
  : Card(
    color: Color.fromRGBO(254, 233, 225, 1),
    elevation: 2,
    margin: EdgeInsets.all(8),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color.fromRGBO(254, 233, 225, 1),
      ),
      height: height / 8,
      child: Center(
        child: ListTile(
          leading: Icon(Icons.not_interested),
          iconColor: Colors.red,
          title: Text(
            "${item.description}",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            "${item.status}",
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ),
  );
}

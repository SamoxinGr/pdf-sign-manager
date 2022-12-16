import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/work_page/cubit/work_page_cubit.dart';

import '../models/TaskClass.dart';
import '../models/UserClass.dart';

Widget taskCard(TaskClass item, BuildContext context, WorkLoadedState state ) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  return Card(
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
          leading: Icon(Icons.change_circle_outlined, size: 30,),
          iconColor: Colors.orange,
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
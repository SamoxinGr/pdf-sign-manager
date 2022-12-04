import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/work_page/cubit/work_page_cubit.dart';

import '../models/UserClass.dart';

Widget openedTaskCard(UserClass item, BuildContext context, TaskOpenedLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  return Card(
    color: Color.fromRGBO(254, 233, 225, 1),
    elevation: 2,
    margin: EdgeInsets.all(8),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color.fromRGBO(254, 233, 225, 1),
      ),
      height: height/10,
      child: Center(child: Text("${item.name}", style: TextStyle(color: Colors.black, backgroundColor: CupertinoColors.systemGreen),)),
    ),
  );
}
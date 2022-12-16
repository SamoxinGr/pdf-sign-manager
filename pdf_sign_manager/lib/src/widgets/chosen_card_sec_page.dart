import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/second_page/cubit/second_page_cubit.dart';

import '../models/TaskClass.dart';

Widget chosenTaskSecCard(TaskClass item, BuildContext context, TaskOpenedLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  return Card(
    color: Color.fromRGBO(254, 233, 225, 1),
    elevation: 2,
    margin: EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color.fromRGBO(254, 233, 225, 1),
        ),
        //child: Center(child: Text("Описание: ${item.description}", style: TextStyle(color: Colors.black,),)),
        child: Column(
          children: [
            Container(
              height: height / 50,
              alignment: Alignment.centerLeft,
              child: Text(
                "От кого: ${item.from}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
                height: height / 10,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Задача: ${item.description}",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}
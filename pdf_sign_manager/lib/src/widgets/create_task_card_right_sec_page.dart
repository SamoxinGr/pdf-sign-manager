import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/second_page/cubit/second_page_cubit.dart';

import '../models/TaskClass.dart';
import '../utils/database_service.dart';

Widget createRightTaskSecCard(
    BuildContext context, TaskCreateLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  TextEditingController descriptionTextInputController =
      TextEditingController();
  TextEditingController toTextInputController = TextEditingController();
  DatabaseService service = DatabaseService();
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
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              autocorrect: false,
              controller: toTextInputController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Кому: ',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              height: height / 100,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              autocorrect: false,
              maxLines: 4,
              controller: descriptionTextInputController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Введите описание',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              height: height / 100,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    if (state.currentUser.job != "specialist") {
                      await service.addTask("task", state.currentUser.job,
                          descriptionTextInputController.text.trim(),
                          state.currentUser.job, "in progress",
                          toTextInputController.text.trim());
                      context.read<SecondCubit>().loadSecond();
                    }
                    else {
                      _showMyDialog(context);
                      context.read<SecondCubit>().loadSecond();
                    }
                  },
                  child: Text("Отправить",
                      style:
                          TextStyle(color: Color.fromRGBO(254, 233, 225, 1))),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(72, 57, 42, 1),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                )),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> _showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(254, 233, 225, 1),
        title: const Text('У Вас нет доступа'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Вы не можете создавать задачи.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ок', style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
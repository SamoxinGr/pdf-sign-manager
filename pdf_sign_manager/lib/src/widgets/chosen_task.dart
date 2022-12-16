import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pdf_sign_manager/src/pages/work_page/cubit/work_page_cubit.dart';

import '../models/TaskClass.dart';
import '../utils/database_service.dart';

Widget chosenTaskCard(
    TaskClass item, BuildContext context, TaskOpenedLoadedState state) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  DatabaseService service = DatabaseService();
  return Card(
    color: const Color.fromRGBO(254, 233, 225, 1),
    elevation: 2,
    margin: const EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color.fromRGBO(254, 233, 225, 1),
        ),
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
            state.currentUser.job == "specialist"
                ? //если специалист, то меньше кнопок
                Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text("Приложить файл",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1)),
                            textAlign: TextAlign.center),
                      )),
                      Container(
                        width: width / 120,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (item.customer == item.to) {
                            //если заказчик и параметр кому совпадают, то отменяем задачу
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.from,
                                "cancelled",
                                item.to);
                            context.read<WorkCubit>().loadWork();
                          } else {
                            //другой человек не сможет отменить задачу
                            _showMyDialog(context);
                            context.read<WorkCubit>().loadWork();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text("Отклонить",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1))),
                      )),
                      Container(
                        width: width / 120,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (item.customer == item.to) {
                            //если заказчик и параметр кому совпадают, то принимаем
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.from,
                                "done",
                                item.to);
                            context.read<WorkCubit>().loadWork();
                          } else {
                            //передаем человеку выше
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.to,
                                "in progress",
                                item.from);
                            context.read<WorkCubit>().loadWork();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text("Подписать",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1))),
                      )),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text(
                          "Открыть файл",
                          style: TextStyle(
                              color: Color.fromRGBO(254, 233, 225, 1)),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      Container(
                        width: width / 120,
                      ),
                      state.currentUser.job == item.customer
                          ? Expanded(
                              child: ElevatedButton(
                              onPressed: () async {
                                await service.updateTask(
                                    "task",
                                    item.id,
                                    item.customer,
                                    item.description,
                                    item.to,
                                    "in progress",
                                    item.from);
                                context.read<WorkCubit>().loadWork();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(72, 57, 42, 1),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: const Text("Доработать",
                                  style: TextStyle(
                                      color: Color.fromRGBO(254, 233, 225, 1)),
                                  textAlign: TextAlign.center),
                            ))
                          : Expanded(
                              child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(72, 57, 42, 1),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: const Text("Приложить файл",
                                  style: TextStyle(
                                      color: Color.fromRGBO(254, 233, 225, 1)),
                                  textAlign: TextAlign.center),
                            )),
                      Container(
                        width: width / 120,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (item.customer == item.to) {
                            //если заказчик и параметр кому совпадают, то отменяем задачу
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.from,
                                "cancelled",
                                item.to);
                            context.read<WorkCubit>().loadWork();
                          } else {
                            //другой человек не сможет отменить задачу
                            _showMyDialog(context);
                            context.read<WorkCubit>().loadWork();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text("Отклонить",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1))),
                      )),
                      Container(
                        width: width / 120,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (item.customer == item.to) {
                            //если заказчик и параметр кому совпадают, то принимаем
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.from,
                                "done",
                                item.to);
                            context.read<WorkCubit>().loadWork();
                          } else {
                            //передаем человеку выше
                            await service.updateTask(
                                "task",
                                item.id,
                                item.customer,
                                item.description,
                                item.to,
                                "in progress",
                                item.from);
                            context.read<WorkCubit>().loadWork();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        child: const Text("Подписать",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1))),
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
        backgroundColor: const Color.fromRGBO(254, 233, 225, 1),
        title: const Text('У Вас нет доступа'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Отменить задачу может только заказчик.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Ок',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

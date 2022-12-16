import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_sign_manager/src/models/TaskClass.dart';

import '../../../models/UserClass.dart';
import 'package:pdf_sign_manager/src/utils/database_service.dart';

part 'second_page_state.dart';

class SecondCubit extends Cubit<SecondState> {

  SecondCubit() : super(SecondInitial());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("state is initial");
    }
  }

  Future<void> loadSecond() async {
    DatabaseService service = DatabaseService();
    List<UserClass> userList = await service.retrieveUserData('team');

    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    UserClass currentUser = await service.getUser(userEmail, "team");  //получили авторизованного пользователя

    List<TaskClass> taskList = await service.retrieveDoneTaskData("task", currentUser.job, "in progress");

    try {
      print("Second loadSecond is loaded");
      emit(SecondLoadedState(currentUser, userList, taskList));
    } catch (e){
      if (isClosed == false) {
        emit(SecondErrorState());
      }
    }
  }

  Future<void> openTask(TaskClass task, List<TaskClass> taskList, UserClass currentUser) async {
    try {
      print("Task opened");
      emit(TaskOpenedLoadedState(task, taskList, currentUser));
    } catch (e){
      if (isClosed == false) {
        emit(SecondErrorState());
      }
    }
  }

  Future<void> createTask(List<TaskClass> taskList, UserClass currentUser) async {
    try {
      print("Task creating");
      emit(TaskCreateLoadedState(taskList, currentUser));
    } catch (e){
      if (isClosed == false) {
        emit(SecondErrorState());
      }
    }
  }

  Future<void> reloadSecond() async {
    if (isClosed == false) {
      print("haha");
      emit(SecondInitial());
    }
  }
}


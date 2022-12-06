import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_sign_manager/src/models/TaskClass.dart';

import '../../../models/UserClass.dart';
import 'package:pdf_sign_manager/src/utils/database_service.dart';

part 'work_page_state.dart';

class WorkCubit extends Cubit<WorkState> {

  WorkCubit() : super(WorkInitial());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("state is initial");
    }
  }

  Future<void> loadWork() async {
    DatabaseService service = DatabaseService();
    List<UserClass> userList = await service.retrieveUserData('team');

    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    UserClass currentUser = await service.getUser(userEmail, "team");  //получили авторизованного пользователя

    List<TaskClass> taskList = await service.retrieveTaskData("task", currentUser.job);

    try {
      print("Work is loaded");
      emit(WorkLoadedState(currentUser, userList, taskList));
    } catch (e){
      if (isClosed == false) {
        emit(WorkErrorState());
      }
    }
  }

  Future<void> openTask(TaskClass task, List<TaskClass> taskList, UserClass currentUser) async {
    try {
      print("Task opened");
      emit(TaskOpenedLoadedState(task, taskList, currentUser));
    } catch (e){
      if (isClosed == false) {
        emit(WorkErrorState());
      }
    }
  }

  Future<void> reloadWork() async {
    if (isClosed == false) {
      print("haha");
      emit(WorkInitial());
    }
  }
}


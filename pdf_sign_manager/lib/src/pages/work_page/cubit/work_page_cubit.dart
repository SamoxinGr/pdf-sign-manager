import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/UserClass.dart';
import 'package:pdf_sign_manager/src/utils/database_service.dart';

import '../../../utils/database_service.dart';

part 'work_page_state.dart';

class WorkCubit extends Cubit<WorkState> {

  WorkCubit() : super(WorkInitial());

  Future<void> informInitial() async {
    if (kDebugMode) {
      print("Work page is loading");
    }
  }

  Future<void> loadWork() async {
    List<String> test_list = ["1", "2", "3", "4", "5"];
    DatabaseService service = DatabaseService();
    List<UserClass> userList = await service.retrieveData('team');
    //print(userList[0].name);
    try {
      print("Work is loaded");
      emit(WorkLoadedState(userList));
    } catch (e){
      if (isClosed == false) {
        emit(WorkErrorState());
      }
    }
  }

  Future<void> openTask(UserClass user, List<UserClass> list) async {
    try {
      print("Task opened");
      emit(TaskOpenedLoadedState(user, list));
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


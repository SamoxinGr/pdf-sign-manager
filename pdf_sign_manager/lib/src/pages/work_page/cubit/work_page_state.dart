part of 'work_page_cubit.dart';


@immutable
abstract class WorkState {}

class WorkInitial extends WorkState {

}

class WorkLoadedState extends WorkState {
  UserClass currentUser;
  List<UserClass> userList;
  //Iterable<dynamic> specialists;
  List<TaskClass> taskList;
  WorkLoadedState(this.currentUser, this.userList, this.taskList);
}

class TaskOpenedLoadedState extends WorkState {
  TaskClass task;
  List<TaskClass> taskList;
  UserClass currentUser;//userList
  TaskOpenedLoadedState(this.task, this.taskList, this.currentUser);
}

class WorkErrorState extends WorkState {
  WorkErrorState();
}
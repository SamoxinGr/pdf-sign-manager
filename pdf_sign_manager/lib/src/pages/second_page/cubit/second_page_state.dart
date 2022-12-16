part of 'second_page_cubit.dart';


@immutable
abstract class SecondState {}

class SecondInitial extends SecondState {

}

class SecondLoadedState extends SecondState {
  UserClass currentUser;
  List<UserClass> userList;
  //Iterable<dynamic> specialists;
  List<TaskClass> taskList;
  SecondLoadedState(this.currentUser, this.userList, this.taskList);
}

class TaskOpenedLoadedState extends SecondState {
  TaskClass task;
  List<TaskClass> taskList;
  UserClass currentUser; //userList
  TaskOpenedLoadedState(this.task, this.taskList, this.currentUser);
}

class TaskCreateLoadedState extends SecondState {
  List<TaskClass> taskList;
  UserClass currentUser;
  TaskCreateLoadedState(this.taskList, this.currentUser);
}

class SecondErrorState extends SecondState {
  SecondErrorState();
}
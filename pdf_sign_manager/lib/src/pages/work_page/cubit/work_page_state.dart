part of 'work_page_cubit.dart';


@immutable
abstract class WorkState {}

class WorkInitial extends WorkState {
}

class WorkLoadedState extends WorkState {
  List<UserClass> userList;
  //Iterable<dynamic> specialists;
  WorkLoadedState(this.userList);
}

class TaskOpenedLoadedState extends WorkState {
  UserClass user;
  List<UserClass> list;  //userList
  TaskOpenedLoadedState(this.user, this.list);
}

class WorkErrorState extends WorkState {
  WorkErrorState();
}
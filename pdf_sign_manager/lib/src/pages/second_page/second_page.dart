import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_horizontal_divider/flutter_horizontal_divider.dart';

import '../../widgets/chosen_card_sec_page.dart';
import '../../widgets/create_task_card_left_sec_page.dart';
import '../../widgets/create_task_card_right_sec_page.dart';
import '../../widgets/opened_task_card_sec_page.dart';
import '../../widgets/task_card_sec_page.dart';
import '../error_page.dart';
import 'cubit/second_page_cubit.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SecondCubit(), child: const _SecondPage());
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<SecondCubit, SecondState>(builder: (context, state) {
      if (state is SecondInitial) {
        context.read<SecondCubit>().informInitial();
        context.read<SecondCubit>().loadSecond();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(254, 233, 225, 1)),
                    ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 6),
                Flexible(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Color.fromRGBO(254, 233, 225, 1)),
                      ),
                    )),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is SecondLoadedState) {
        print("Loaded Second");
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: state.taskList.isEmpty
                        ? Column(
                            children: [
                              const Flexible(
                                flex: 4,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Color.fromRGBO(254, 233, 225, 1),
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color: Color.fromRGBO(
                                                254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        : Column(
                            children: [
                              Flexible(
                                flex: 4,
                                child: ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: state.taskList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => context
                                            .read<SecondCubit>()
                                            .openTask(
                                                state.taskList[index],
                                                state.taskList,
                                                state.currentUser),
                                        child: taskSecCard(
                                            state.taskList[index],
                                            context,
                                            state),
                                      );
                                    }),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color: Color.fromRGBO(
                                                254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 6),
                Flexible(
                    flex: 4,
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color.fromRGBO(146, 170, 131, 0.95),
                        ),
                        child: const Center(
                          child: Text(
                            "Task",
                            style: TextStyle(
                                color: Color.fromRGBO(254, 233, 225, 1),
                                fontSize: 24),
                          ),
                        ))),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is TaskOpenedLoadedState) {
        print("Opening Task");
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: state.taskList.isEmpty
                        ? Column(
                            children: [
                              const Flexible(
                                flex: 4,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Color.fromRGBO(254, 233, 225, 1),
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color: Color.fromRGBO(
                                                254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        : Column(
                            children: [
                              Flexible(
                                flex: 4,
                                child: ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: state.taskList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => context
                                            .read<SecondCubit>()
                                            .openTask(
                                                state.taskList[index],
                                                state.taskList,
                                                state.currentUser),
                                        child: openedTaskSecCard(
                                            state.taskList[index],
                                            context,
                                            state),
                                      );
                                    }),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color: Color.fromRGBO(
                                                254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 6),
                Flexible(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () =>
                                  context.read<SecondCubit>().loadSecond(),
                              child:
                                  chosenTaskSecCard(state.task, context, state),
                            );
                          }),
                    )),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is TaskCreateLoadedState) {
        print("Creating Task");
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: state.taskList.isEmpty
                        ? Column(
                            children: [
                              const Flexible(
                                flex: 4,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Color.fromRGBO(254, 233, 225, 1),
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color:
                                                Color.fromRGBO(254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
                        : Column(
                            children: [
                              Flexible(
                                flex: 4,
                                child: ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: state.taskList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => context
                                            .read<SecondCubit>()
                                            .openTask(
                                                state.taskList[index],
                                                state.taskList,
                                                state.currentUser),
                                        child: createLeftTaskSecCard(
                                            state.taskList[index],
                                            context,
                                            state),
                                      );
                                    }),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => context
                                              .read<SecondCubit>()
                                              .createTask(state.taskList,
                                                  state.currentUser),
                                          child: Card(
                                            color: Color.fromRGBO(
                                                254, 233, 225, 1),
                                            elevation: 2,
                                            margin: EdgeInsets.all(8),
                                            child: Container(
                                              height: height / 8,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                color: Color.fromRGBO(
                                                    254, 233, 225, 1),
                                              ),
                                              child: const Center(
                                                child: Text("Create Task",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 6),
                Flexible(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () =>
                                  context.read<SecondCubit>().loadSecond(),
                              child: createRightTaskSecCard(context, state),
                            );
                          }),
                    )),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is SecondErrorState) {
        return ErrorPage(exPageName: "SecondPage");
      } else {
        return Container();
      }
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_horizontal_divider/flutter_horizontal_divider.dart';
import 'package:pdf_sign_manager/src/pages/work_page/cubit/work_page_cubit.dart';

import '../../widgets/chosen_task.dart';
import '../../widgets/opened_task_card.dart';
import '../../widgets/task_card.dart';
import '../error_page.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => WorkCubit(), child: const _WorkPage());
  }
}

class _WorkPage extends StatelessWidget {
  const _WorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<WorkCubit, WorkState>(builder: (context, state) {
      if (state is WorkInitial) {
        context.read<WorkCubit>().informInitial();
        context.read<WorkCubit>().loadWork();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: const Center(
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const HorizontalDivider(thickness: 1, height: 6),
                      Flexible(
                        flex: 7,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
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
                        child: CircularProgressIndicator(),
                      ),
                    )),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is WorkLoadedState) {
        print("Loaded Work");
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: Center(
                              child: ListTile(
                            title: Text(
                              "${state.currentUser.name}",
                              style: const TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              "${state.currentUser.job}",
                              style: const TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ),
                      ),
                      const HorizontalDivider(thickness: 1, height: 6),

                      Flexible(
                        flex: 7,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: state.taskList.isEmpty ?
                          const Center(
                            child: Text(
                              "Empty",
                              style: TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 22),
                            ),
                          )
                                : ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: state.taskList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => context
                                      .read<WorkCubit>()
                                      .openTask(state.taskList[index],
                                          state.taskList, state.currentUser),
                                  child: taskCard(
                                      state.taskList[index], context, state),
                                );
                              }),
                        ),
                      ),
                    ],
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
                            "Choose the task",
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
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: Center(
                              child: ListTile(
                            title: Text(
                              "${state.currentUser.name}",
                              style: const TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              "${state.currentUser.job}",
                              style: const TextStyle(
                                  color: Color.fromRGBO(254, 233, 225, 1),
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ),
                      ),
                      const HorizontalDivider(thickness: 1, height: 6),

                      Flexible(
                        flex: 7,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(146, 170, 131, 0.95),
                          ),
                          child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: state.taskList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => context
                                      .read<WorkCubit>()
                                      .openTask(state.taskList[index],
                                      state.taskList, state.currentUser),
                                  child: openedTaskCard(
                                      state.taskList[index], context, state),
                                );
                              }),
                        ),
                      ),
                    ],
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
                              onTap: () => context.read<WorkCubit>().loadWork(),
                              child: chosenTaskCard(
                                  state.task, context, state),
                            );
                          }),
                    )),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is WorkErrorState) {
        return ErrorPage(exPageName: "WorkPage");
      } else {
        return Container();
      }
    });
  }
}

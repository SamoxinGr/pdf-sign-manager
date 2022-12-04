import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        print("state is initial");
        context.read<WorkCubit>().loadWork();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: Center(
                      child: Text(
                        "Here nothing",
                        style: TextStyle(
                            color: Color.fromRGBO(254, 233, 225, 1),
                            fontSize: 24),
                      ),
                    ),
                  ),
                ),

                const VerticalDivider(thickness: 1, width: 6),

                Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: Center(
                        child: Text(
                          "Choose the task",
                          style: TextStyle(
                              color: Color.fromRGBO(254, 233, 225, 1),
                              fontSize: 24),
                        ),
                      ),
                    ),
                    flex: 4),
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: state.userList.length,
                        itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => context.read<WorkCubit>().openTask(state.userList[index], state.userList),
                        child: taskCard(state.userList[index], context, state),
                      );
                    }),
                  ),
                ),

                const VerticalDivider(thickness: 1, width: 6),

                Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: Center(
                        child: Text(
                          "Choose the task",
                          style: TextStyle(
                              color: Color.fromRGBO(254, 233, 225, 1),
                              fontSize: 24),
                        ),
                      )
                    ),
                    flex: 4),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromRGBO(146, 170, 131, 0.95),
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => context.read<WorkCubit>().loadWork(),
                            child: openedTaskCard(state.list[index], context, state),
                          );
                        }),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 6),
                Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Color.fromRGBO(146, 170, 131, 0.95),
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => context.read<WorkCubit>().loadWork(),
                              child: chosenTaskCard(state.user, context, state),
                            );
                          }),
                    ),
                    flex: 4),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(72, 57, 42, 1),
        );
      }

      if (state is WorkErrorState) {
        return const ErrorPage(
            exPageName: "WorkPage");
      } else {
        return Container();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_model.dart';

import '../../../core/firebase_utils.dart';
import '../../../core/settings_provider.dart';

class TasksItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TasksItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: provider.isDark() ? const Color(0xff141922) : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils.deleteTask(taskModel)
                    .then((value) => EasyLoading.dismiss());
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          decoration: BoxDecoration(
            color: provider.isDark() ? const Color(0xff141922) : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            leading: Container(
              width: 6,
              height: 80,
              decoration: BoxDecoration(
                color: taskModel.isDone
                    ? const Color(0xff61e757)
                    : theme.primaryColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskModel.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    color: taskModel.isDone
                        ? const Color(0xff61e757)
                        : theme.primaryColorLight,
                  ),
                ),
                Row(
                  children: [
                    Text(
                        DateFormat("dd MMM, yy").format(taskModel.selectedDate),
                        style: theme.textTheme.displaySmall),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.alarm,
                      size: 18,
                      color: provider.isDark() ? Colors.white : Colors.black,
                    )
                  ],
                ),
              ],
            ),
            trailing: taskModel.isDone
                ? Text(
                    "Done",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: const Color(0xff61e757),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      EasyLoading.show();
                      FirebaseUtils.updateTask(taskModel)
                          .then((onValue) => EasyLoading.dismiss());
                    },
                    child: Container(
                      width: 75,
                      height: 35,
                      decoration: BoxDecoration(
                          color: theme.primaryColorLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

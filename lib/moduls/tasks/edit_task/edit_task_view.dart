import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/model/task_model.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    TaskModel taskModel =
        ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 50),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Edit Task!"),
            const Spacer(),
            TextFormField(
              initialValue: taskModel.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: theme.primaryColorLight,
              ),
              onChanged: (value) {
                taskModel.title = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColorLight),
                  ),
                  hintText: "Title",
                  hintStyle: const TextStyle(fontSize: 15, color: Colors.blue)),
            ),
            const Spacer(),
            TextFormField(
              initialValue: taskModel.description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: theme.primaryColorLight,
              ),
              onChanged: (value) {
                taskModel.description = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColorLight),
                  ),
                  labelStyle: const TextStyle(fontSize: 15, color: Colors.blue),
                  hintText: "Description",
                  hintStyle: const TextStyle(fontSize: 15, color: Colors.blue)),
            ),
            const Spacer(),
            Text(
              "Select time",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        // initialDate: DateUtils.dateOnly(
                        //       DateTime(taskModel.selectedDate)
                        //     ),
                        // initialDate: DateFormat("dd MMM, yy").format(taskModel.selectedDate),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)))
                    .then((value) =>
                        {taskModel.selectedDate = DateUtils.dateOnly(value!)});
                setState(() {});
                //
                // showDatePicker(
                //     context: context,
                //     initialDate: DateUtils.dateOnly(
                //       DateTime.fromMillisecondsSinceEpoch(taskModel.selectedDate as int)
                //     ),
                //     lastDate: DateTime.now().add(Duration(days: 365)),
                //     firstDate: DateTime.now());
              },
              child: Text(
                  DateFormat("dd MMM, yy").format(taskModel.selectedDate),
                  style: theme.textTheme.displaySmall
                  // DateUtils.dateOnly(
                  //   DateTime.fromMillisecondsSinceEpoch(taskModel.selectedDate as int)
                  // ).toString()
                  ),
            ),
            // InkWell(
            //   onTap: () {
            //     getSelectedDate();
            //   },
            //   child: Text(
            //     // selectedDate.toString(),
            //     DateFormat("dd MMM yyyy").format(selectedDate),
            //     style: theme.textTheme.bodyMedium,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColorLight,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  FirebaseUtils.updateAllTask(taskModel);
                  Navigator.pop(context);
                },
                child: Text(
                  "Edit Task",
                  style: theme.textTheme.bodyMedium,
                )),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: theme.textTheme.bodyMedium,
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

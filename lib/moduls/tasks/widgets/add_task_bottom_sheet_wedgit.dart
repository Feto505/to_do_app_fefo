import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/model/task_model.dart';

class AddTaskBottomSheetWedgit extends StatefulWidget {
  const AddTaskBottomSheetWedgit({super.key});

  @override
  State<AddTaskBottomSheetWedgit> createState() =>
      _AddTaskBottomSheetWedgitState();
}

class _AddTaskBottomSheetWedgitState extends State<AddTaskBottomSheetWedgit> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new Task",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Enter Task Title"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter task title";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descController,
              maxLines: 2,
              decoration:
                  const InputDecoration(hintText: "Enter Task Description"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "plz enter task description";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select time",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                getSelectedDate();
              },
              child: Text(
                // selectedDate.toString(),
                DateFormat("dd MMM yyyy").format(selectedDate),
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: theme.primaryColorLight,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var taskModel = TaskModel(
                        title: titleController.text,
                        description: descController.text,
                        selectedDate: selectedDate);
                    EasyLoading.show();
                    FirebaseUtils.addTaskToFirestore(taskModel).then((value) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage("Done");
                      // print("add task");
                    });
                  }
                },
                child: Text(
                  "save",
                  style:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  getSelectedDate() async {
    var currentDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}

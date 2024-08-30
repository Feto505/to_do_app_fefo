import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/moduls/tasks/widgets/tasks_item_widget.dart';

import '../../core/settings_provider.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    var lang = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.1),
          child: Stack(
            clipBehavior: Clip.none,
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.22,
                color: theme.primaryColorLight,
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: mediaQuery.size.height * 0.06),
                child: Text(
                  lang.to_do_list,
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color:
                          provider.isDark() ? Color(0xff141922) : Colors.white),
                ),
              ),
              Positioned(
                top: 125,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime(2025, 12, 31),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                      });
                    },
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: provider.isDark()
                                ? Color(0xff141922)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        dayStrStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: theme.primaryColorLight,
                        ),
                        dayNumStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: theme.primaryColorLight,
                        ),
                        monthStrStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: theme.primaryColorLight,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: provider.isDark()
                                ? Color(0xff141922).withOpacity(0.70)
                                : Colors.white.withOpacity(0.80),
                            borderRadius: BorderRadius.circular(12)),
                        dayStrStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                        dayNumStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                        monthStrStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    showTimelineHeader: false,

                    // width: mediaQuery.size.width,
                    // height: 100,
                    //  color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded(//replace it with ....
        //   child: ListView.builder(
        //     padding: EdgeInsets.zero,
        //       itemBuilder: (context,index)=>TasksItemWidget(),
        //   itemCount: 2,),
        // )
        // Expanded(
        //   // flex: 2,
        //   child: FutureBuilder<List<TaskModel>>(
        //       future: FirebaseUtils.getOnTimeReadFromFirestore(_focusDate),
        //       builder: (context,snapshot){
        //         print(snapshot.error);
        //         if(snapshot.hasError){
        //           return Text("Something went error");
        //         }
        //         if(snapshot.connectionState == ConnectionState.waiting){
        //           return Center(
        //             child: CircularProgressIndicator(
        //               color: theme.primaryColorLight,
        //             ),
        //           );
        //         }
        //         var tasksList =snapshot.data;
        //         return ListView.builder(
        //           padding: EdgeInsets.zero,
        //             itemBuilder: (context,index)=>TasksItemWidget(
        //               taskModel: tasksList![index],
        //             ),
        //         itemCount: tasksList?.length??0,
        //         )  ;
        //
        //       }),
        // ),
        Expanded(
          // flex: 2,
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseUtils.getRealTimeDateFromFirestore(_focusDate),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // return const Text("Something went error");
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColorLight,
                    ),
                  );
                }
                List<TaskModel> tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                // List<TaskModel> tasksList =snapshot.data?? [];
                // var tasksList =snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => TasksItemWidget(
                    taskModel: tasksList![index],
                  ),
                  itemCount: tasksList?.length ?? 0,
                );
              }),
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.099,
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.03,
        )
      ],
    );
  }
}

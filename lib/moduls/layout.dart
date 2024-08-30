import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/moduls/settings/settings_view.dart';
import 'package:todo_app/moduls/tasks/tasks_view.dart';
import 'package:todo_app/moduls/tasks/widgets/add_task_bottom_sheet_wedgit.dart';

import '../core/settings_provider.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> screens = [
    const TasksView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      //show behind color
      body: screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: provider.isDark() ? Color(0xff141922) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskBottomSheetWedgit());
        },
        child: CircleAvatar(
            radius: 25,
            backgroundColor: theme.primaryColorLight,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 105,
        color: provider.isDark() ? Color(0xff141922) : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: "Tasks",
                icon: ImageIcon(AssetImage("assets/icons/icon_list.png"))),
            BottomNavigationBarItem(
                label: "settings",
                icon: ImageIcon(AssetImage("assets/icons/icon_settings.png"))),
          ],
        ),
      ),
    );
  }
}

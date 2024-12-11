import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/main_view_model.dart';
import 'package:first_application/views/today_task_screen.dart';
import 'package:first_application/views/add_task_screen.dart';
import 'package:first_application/views/folders_screen.dart';
import 'package:first_application/views/profile_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    TodayTask(),
    AddTask(),
    Folders(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _screens[viewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.onTabTapped,
            items: viewModel.tabs.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.title,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

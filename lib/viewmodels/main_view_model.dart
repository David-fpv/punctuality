import 'package:flutter/material.dart';
import 'package:first_application/models/tab_model.dart';

class MainViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<TabItem> tabs = [
    TabItem(title: 'На сегодня', icon: Icons.today),
    TabItem(title: '+ задача', icon: Icons.add_task),
    TabItem(title: 'Папки', icon: Icons.folder),
    TabItem(title: 'Профиль', icon: Icons.person),
  ];

  void onTabTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

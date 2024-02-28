import 'package:flutter/material.dart';

class NavigationService {
  static const dashboardHomeTab = 0;
  static const dashboardLearningTab = 1;
  static const dashboardSettingTab = 2;

  static final navigationKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigationKey.currentContext!;

  void openHome() {
    Navigator.pushNamed(context!, '/');
  }

  void openAddTodo() {
    Navigator.pushNamed(context!, '/add-todo');
  }

  void openUpdateTodo(int key) {
    Navigator.pushNamed(context!, '/edit-todo', arguments: {
      'key': key,
    });
  }

  void back() {
    Navigator.pop(context!);
  }
}

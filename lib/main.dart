import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_weather_bloc/routes.dart';
import 'package:todo_weather_bloc/services/navigation_service.dart';

import 'models/todo.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Todo>(TodoAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: Routes(context).getRoutes(),
      navigatorKey: NavigationService.navigationKey,
    );
  }
}


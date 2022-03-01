import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/data/database.dart';
import 'package:brewing_coffee_timer/pages/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

import 'controllers/new_stage_controller.dart';

AppDatabase appDatabase = AppDatabase();
void main() {
  runApp(MyApp());
  Get.put(StageController());
  Get.put(TimerController());
  Get.put(NewStageController());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => TimerPage()),
      ],
    );
  }
}

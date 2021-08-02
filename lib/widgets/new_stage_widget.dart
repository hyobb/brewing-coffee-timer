import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NewStageWidget extends StatelessWidget {
  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: '제목'),
        ),
        CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.ms,
          minuteInterval: 1,
          secondInterval: 1,
          initialTimerDuration: new Duration(minutes: 1, seconds: 0),
          onTimerDurationChanged: (Duration changedDuration) {
            print('$changedDuration');
          },
        )
      ],
    );
  }
}

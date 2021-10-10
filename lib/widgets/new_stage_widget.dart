import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NewStageWidget extends StatelessWidget {
  final stageController = Get.put(StageController());
  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CloseButton(),
                ElevatedButton(
                  onPressed: () {
                    stageController.addStage();
                    timerController.setStages(stageController.stages);
                  },
                  child: Text('저장'),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: '제목'),
              onChanged: (value) => stageController.setCurrentTitle(value),
            ),
            CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms,
              minuteInterval: 1,
              secondInterval: 1,
              initialTimerDuration: new Duration(minutes: 1, seconds: 0),
              onTimerDurationChanged: (Duration changedDuration) {
                stageController.setCurrentDuration(changedDuration);
                print('$changedDuration');
              },
            )
          ],
        ),
      );
    });
  }
}

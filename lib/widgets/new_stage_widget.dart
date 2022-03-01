import 'package:brewing_coffee_timer/controllers/new_stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NewStageWidget extends StatelessWidget {
  final stageController = Get.find<StageController>();
  final newStageController = Get.find<NewStageController>();

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
                    if (newStageController.index == null) {
                      stageController.addStage(newStageController.stageVO);
                    } else {
                      stageController.updateStage(
                          newStageController.index, newStageController.stageVO);
                    }
                    Get.back();
                  },
                  child: Text('저장'),
                )
              ],
            ),
            TextField(
              controller: TextEditingController()
                ..text = newStageController.stageVO.title,
              decoration: InputDecoration(labelText: '제목'),
              onChanged: (value) => newStageController.setTitle(value),
            ),
            CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms,
              minuteInterval: 1,
              secondInterval: 1,
              initialTimerDuration: newStageController.stageVO.duration,
              onTimerDurationChanged: (Duration changedDuration) {
                newStageController.setDuration(changedDuration);
              },
            )
          ],
        ),
      );
    });
  }
}

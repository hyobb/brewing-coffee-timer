import 'dart:ui';

import 'package:brewing_coffee_timer/controllers/new_stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/models/stageVO.dart';
import 'package:brewing_coffee_timer/widgets/new_stage_widget.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brewing_coffee_timer/extensions/duration.dart';

class TimerPage extends StatelessWidget {
  final stageController = Get.find<StageController>();
  final newStageController = Get.find<NewStageController>();
  final timerController = Get.find<TimerController>();
  // timerController.setStages(stageController.stageVOs);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        child: _body(),
        padding: EdgeInsets.only(top: statusBarHeight),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Get.bottomSheet(Container(
              color: Colors.white,
              height: 400,
              child: NewStageWidget(),
            )).whenComplete(() => {newStageController.resetStage()});
          }),
    );
  }

  Widget _body() {
    return Container(
      child: Column(children: [
        TimerWidget(),
        StageListWidget(),
      ]),
    );
  }
}

class TimerWidget extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(builder: (controller) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: CircularCountDownTimer(
                  duration: controller.currentDurationSeconds.value,
                  initialDuration: 0,
                  controller: controller.stageController,
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.width - 50,
                  ringColor: Colors.grey[700]!,
                  ringGradient: null,
                  fillColor: Colors.yellow[800]!,
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 8.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(fontSize: 30),
                  textFormat: CountdownTextFormat.S,
                  isReverse: false,
                  isReverseAnimation: true,
                  isTimerTextShown: false,
                  autoStart: false,
                  onStart: () {
                    print('Stage CountDown started');
                  },
                  onComplete: () {
                    print('Stage CountDown ended');
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CircularCountDownTimer(
                  duration: controller.totalDurationSeconds,
                  initialDuration: 0,
                  controller: controller.countDownController,
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.width - 20,
                  ringColor: Colors.grey[700]!,
                  ringGradient: null,
                  fillColor: Colors.blue[300]!,
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 8.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(fontSize: 30),
                  textFormat: CountdownTextFormat.S,
                  isReverse: false,
                  isReverseAnimation: true,
                  isTimerTextShown: false,
                  autoStart: false,
                  onStart: () {},
                  onComplete: () {},
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: <Widget>[
                    // Text(
                    //   "총 경과 시간 ${controller.totalElapsedTime} / ${controller.totalTime}",
                    //   style: TextStyle(fontSize: 20, color: Colors.white),
                    // ),
                    Container(
                      height: 30,
                      child: Text(
                        controller.currentStageTitle,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[800],
                      // ),
                      width: MediaQuery.of(context).size.width / 2 + 80,
                      height: 120,
                      alignment: Alignment.center,
                      child: Text(
                        controller.currentRemainedTime,
                        style: TextStyle(
                          fontFeatures: [
                            FontFeature.tabularFigures(),
                          ],
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Text(
                        "${controller.nextStageTitle} ${controller.nextStageTime}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontFeatures: [
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    decoration: new BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: MaterialButton(
                        onPressed: () {
                          controller.stop();
                        },
                        color: Colors.grey[800],
                        textColor: Colors.white,
                        child: Text(
                          '취소',
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                    )),
                Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: getPlayButtonColor(controller.state),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: MaterialButton(
                        onPressed: () {
                          switch (controller.state) {
                            case TimerState.playing:
                              return controller.pause();
                            case TimerState.paused:
                              return controller.start();
                            default:
                              return controller.start();
                          }
                        },
                        color: getPlayButtonColor(controller.state),
                        textColor: getPlayButtonTextColor(controller.state),
                        child: Text(
                          getPlayButtonName(controller.state),
                          textAlign: TextAlign.center,
                        ),
                        shape: CircleBorder(),
                      ),
                    )),
              ],
            ),
            padding: EdgeInsets.only(right: 30, left: 30),
          ),
        ],
      );
    });
  }

  getPlayButtonName(state) {
    switch (state) {
      case TimerState.playing:
        return '일시 정지';
      case TimerState.paused:
        return '재개';
      default:
        return '시작';
    }
  }

  getPlayButtonColor(state) {
    switch (state) {
      case TimerState.playing:
        return Colors.orangeAccent;
      case TimerState.paused:
        return Colors.green[700];
      default:
        return Colors.green[700];
    }
  }

  getPlayButtonTextColor(state) {
    switch (state) {
      case TimerState.playing:
        return Colors.orange[800];
      case TimerState.paused:
        return Colors.greenAccent[400];
      default:
        return Colors.greenAccent[400];
    }
  }
}

class StageListWidget extends GetView<StageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StageController>(
      builder: (controller) {
        return ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.stageVOs.value.length,
          itemBuilder: (context, index) {
            return StageTile(controller.stageVOs.value[index], index);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[800],
              indent: 20,
              endIndent: 20,
            );
          },
        );
      },
    );
  }
}

class StageTile extends StatelessWidget {
  final stageController = Get.find<StageController>();
  final newStageController = Get.find<NewStageController>();
  final StageVO stageVO;
  final int index;

  StageTile(this.stageVO, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        (index + 1).toString(),
        style: TextStyle(color: Colors.white),
      ),
      title: Text(
        stageVO.title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              stageVO.duration.toCustomString(),
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                stageController.deleteStage(index);
              },
            ),
          ],
        ),
      ),
      onTap: () {
        newStageController.setStage(stageVO, index);

        Get.bottomSheet(Container(
          color: Colors.white,
          height: 400,
          child: NewStageWidget(),
        )).whenComplete(() {
          newStageController.resetStage();
        });
      },
    );
  }
}

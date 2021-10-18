import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:brewing_coffee_timer/widgets/new_stage_widget.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerPage extends StatelessWidget {
  final stageController = Get.put(StageController());
  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    timerController.setStages(stageController.stages);

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
            )).whenComplete(() => {stageController.resetCurrentData()});
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
          Container(
            child: CircularCountDownTimer(
              duration: controller.currentDurationSeconds,
              initialDuration: 0,
              controller: controller.countDownController,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              ringColor: Colors.yellow[800]!,
              ringGradient: null,
              fillColor: Colors.white,
              fillGradient: null,
              backgroundColor: Colors.white,
              backgroundGradient: null,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(fontSize: 30),
              textFormat: CountdownTextFormat.S,
              isReverse: false,
              isReverseAnimation: false,
              isTimerTextShown: false,
              autoStart: false,
              onStart: () {
                print('CountDown started');
              },
              onComplete: () {
                print('CountDown ended');
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(
              children: <Widget>[
                Text(
                  "총 경과 시간 ${controller.totalElapsedTime} / ${controller.totalTime}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "${controller.currentStageTitle} ${controller.currentRemainedTime}",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  "${controller.nextStageTitle} ${controller.nextStageTime}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
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
          itemCount: controller.stages.length,
          itemBuilder: (context, index) {
            return StageTile(controller.stages[index]);
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
    // return Obx(() => ListView.separated(
    //       scrollDirection: Axis.vertical,
    //       shrinkWrap: true,
    //       itemCount: controller.stages.length,
    //       itemBuilder: (context, index) {
    //         return StageTile(controller.stages[index]);
    //       },
    //       separatorBuilder: (context, index) {
    //         return Divider();
    //       },
    //     ));
  }
}

class StageTile extends StatelessWidget {
  final Stage stage;

  StageTile(this.stage);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        stage.order.toString(),
        style: TextStyle(color: Colors.white),
      ),
      title: Text(
        stage.title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        stage.duration.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

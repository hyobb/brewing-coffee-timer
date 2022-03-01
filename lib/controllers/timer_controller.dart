import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:math';
import 'package:brewing_coffee_timer/controllers/stage_controller.dart';
import 'package:brewing_coffee_timer/data/database.dart';
import 'package:brewing_coffee_timer/models/stageVO.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:drift/backends.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brewing_coffee_timer/extensions/duration.dart';

class TimerController extends GetxController {
  Duration _zeroPeriod = Duration(minutes: 0, seconds: 0);
  Duration _totalElapsedDuration = Duration(minutes: 0, seconds: 0);
  Duration _currentDuration = Duration(minutes: 0, seconds: 0);
  Duration _totalDuration = Duration(minutes: 0, seconds: 0);
  int _currentStageIndex = 0;
  StageVO? _currentStageVO;
  StageVO? _nextStageVO;
  List<StageVO> _stageVOs = [];
  Timer? _timer;
  TimerState _state = TimerState.beforePlay;
  Duration _period = Duration(milliseconds: 250);
  CountDownController _countDownController = CountDownController();
  CountDownController _stageCountDownController = CountDownController();

  final _stageCont = Get.find<StageController>();

  get stageVOs => _stageVOs;
  get totalElapsedTime => _totalElapsedDuration.toCustomString();
  get totalDurationSeconds => _totalDuration.inSeconds;
  RxInt get currentDurationSeconds => _currentDuration.inSeconds.obs;
  get currentRemainedTime => _currentDuration.toCustomString();
  get totalTime => _totalDuration.toCustomString();
  get currentStageTitle =>
      (_currentStageVO == null) ? '' : _currentStageVO!.title;
  get nextStageTitle => (_nextStageVO == null) ? '' : _nextStageVO!.title;
  get nextStageTime =>
      (_nextStageVO == null) ? '' : _nextStageVO!.duration.toCustomString();
  get state => _state;
  get countDownController => _countDownController;
  get stageController => _stageCountDownController;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _stageCont.stageVOs.listen((value) {
      print('111');
      print(value.toString());
      setStages(value);
      value.forEach((element) {
        print(element.id);
      });
      update();
    });
  }

  @override
  onInit() {
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
  }

  setStages(List<StageVO> stageVOs) {
    print(stageVOs);
    if (stageVOs.isEmpty) {
      return;
    }

    _stageVOs = stageVOs;
    _totalDuration = stageVOs
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    _currentStageVO = _stageVOs.first;
    _currentDuration = _currentStageVO!.duration;
    if (_stageVOs.length > 1) {
      _nextStageVO = _stageVOs[_currentStageIndex + 1];
    }

    update();
  }

  start() {
    if (_stageVOs.isEmpty || _state == TimerState.playing) {
      return;
    }

    if (_state == TimerState.done) {
      stop();
    }

    if (_state == TimerState.paused) {
      _countDownController.resume();
      _stageCountDownController.resume();
    } else {
      _countDownController.restart(duration: _totalDuration.inSeconds);
      _stageCountDownController.restart(duration: _currentDuration.inSeconds);
    }

    changeState(TimerState.playing);

    _timer = Timer.periodic(_period, (timer) {
      _currentDuration = _currentDuration - Duration(milliseconds: 250);
      _totalElapsedDuration =
          _totalElapsedDuration + Duration(milliseconds: 250);

      if (_currentDuration == _zeroPeriod) {
        _currentStageVO!.isDone = true;

        if (_currentStageIndex < _stageVOs.length - 1) {
          // 다음 스테이지
          _currentStageIndex++;
          _currentStageVO = _nextStageVO;
          _currentDuration = _currentStageVO!.duration;
          _stageCountDownController.restart(
              duration: _currentDuration.inSeconds);
          update();

          if (_currentStageIndex + 1 < _stageVOs.length) {
            _nextStageVO = stageVOs[_currentStageIndex + 1];
          } else {
            _nextStageVO = null;
          }
        } else {
          _nextStageVO = null;
        }
      } else {}

      if (_totalElapsedDuration == _totalDuration) {
        finish();
      }

      update();
    });
  }

  changeState(TimerState state) {
    _state = state;
    update();
  }

  stop() {
    _timer?.cancel();
    _totalElapsedDuration = _zeroPeriod;
    _currentStageIndex = 0;
    _countDownController.restart();
    _countDownController.pause();
    _stageCountDownController.restart();
    _stageCountDownController.pause();
    changeState(TimerState.stopped);
    setStages(_stageVOs);
  }

  pause() {
    _timer?.cancel();
    _countDownController.pause();
    _stageCountDownController.pause();
    changeState(TimerState.paused);
  }

  finish() {
    _timer?.cancel();
    changeState(TimerState.done);
  }
}

enum TimerState { beforePlay, playing, paused, stopped, done }

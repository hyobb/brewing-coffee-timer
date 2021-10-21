import 'dart:async';
import 'dart:ffi';
import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brewing_coffee_timer/extensions/duration.dart';

class TimerController extends GetxController {
  Duration _zeroPeriod = Duration(minutes: 0, seconds: 0);
  Duration _totalElapsedDuration = Duration(minutes: 0, seconds: 0);
  Duration _currentDuration = Duration(minutes: 0, seconds: 0);
  Duration _totalDuration = Duration(minutes: 0, seconds: 0);
  int _currentStageIndex = 0;
  Stage? _currentStage;
  Stage? _nextStage;
  List<Stage> _stages = [];
  Timer? _timer;
  TimerState _state = TimerState.beforePlay;
  Duration _period = Duration(seconds: 1);
  CountDownController _countDownController = CountDownController();

  get stages => _stages;
  get totalElapsedTime => _totalElapsedDuration.toCustomString();
  get currentDurationSeconds => _currentDuration.inSeconds;
  get currentRemainedTime => _currentDuration.toCustomString();
  get totalTime => _totalDuration.toCustomString();
  get currentStageTitle => (_currentStage == null) ? '' : _currentStage!.title;
  get nextStageTitle => (_nextStage == null) ? '' : _nextStage!.title;
  get nextStageTime =>
      (_nextStage == null) ? '' : _nextStage!.duration.toCustomString();
  get state => _state;
  get countDownController => _countDownController;

  @override
  onInit() {
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
  }

  setStages(List<Stage> stages) {
    _stages = stages;
    _totalDuration = stages
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    _currentStage = _stages.first;
    _currentDuration = _currentStage!.duration;
    if (_stages.length > 1) {
      _nextStage = _stages[_currentStageIndex + 1];
    }
    update();
  }

  start() {
    if (_stages.isEmpty || _state == TimerState.playing) {
      return;
    }

    if (_state == TimerState.done) {
      stop();
    }

    changeState(TimerState.playing);
    _countDownController.start();

    _timer = Timer.periodic(_period, (timer) {
      _currentDuration = _currentDuration - Duration(seconds: 1);
      _totalElapsedDuration = _totalElapsedDuration + Duration(seconds: 1);

      if (_currentDuration == _zeroPeriod) {
        _currentStage!.isDone = true;

        if (_currentStageIndex < _stages.length - 1) {
          _currentStageIndex++;
          _currentStage = _nextStage;
          _currentDuration = _currentStage!.duration;

          if (_currentStageIndex + 1 < _stages.length) {
            _nextStage = stages[_currentStageIndex + 1];
          } else {
            _nextStage = null;
          }
        } else {
          _nextStage = null;
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
    changeState(TimerState.stopped);
    setStages(_stages);
    update();
  }

  pause() {
    _timer?.cancel();
    changeState(TimerState.paused);
    update();
  }

  finish() {
    _timer?.cancel();
    changeState(TimerState.done);
  }
}

enum TimerState { beforePlay, playing, paused, stopped, done }

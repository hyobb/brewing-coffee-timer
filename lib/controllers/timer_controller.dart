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
  Duration _period = Duration(milliseconds: 250);
  CountDownController _countDownController = CountDownController();
  CountDownController _stageController = CountDownController();

  get stages => _stages;
  get totalElapsedTime => _totalElapsedDuration.toCustomString();
  get totalDurationSeconds => _totalDuration.inSeconds;
  RxInt get currentDurationSeconds => _currentDuration.inSeconds.obs;
  get currentRemainedTime => _currentDuration.toCustomString();
  get totalTime => _totalDuration.toCustomString();
  get currentStageTitle => (_currentStage == null) ? '' : _currentStage!.title;
  get nextStageTitle => (_nextStage == null) ? '' : _nextStage!.title;
  get nextStageTime =>
      (_nextStage == null) ? '' : _nextStage!.duration.toCustomString();
  get state => _state;
  get countDownController => _countDownController;
  get stageController => _stageController;

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

    if (_state == TimerState.paused) {
      _countDownController.resume();
      _stageController.resume();
    } else {
      _countDownController.restart(duration: _totalDuration.inSeconds);
      _stageController.restart(duration: _currentDuration.inSeconds);
    }

    changeState(TimerState.playing);

    _timer = Timer.periodic(_period, (timer) {
      _currentDuration = _currentDuration - Duration(milliseconds: 250);
      _totalElapsedDuration =
          _totalElapsedDuration + Duration(milliseconds: 250);

      if (_currentDuration == _zeroPeriod) {
        _currentStage!.isDone = true;

        if (_currentStageIndex < _stages.length - 1) {
          // 다음 스테이지
          _currentStageIndex++;
          _currentStage = _nextStage;
          _currentDuration = _currentStage!.duration;
          _stageController.restart(duration: _currentDuration.inSeconds);
          update();

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
    _countDownController.restart();
    _countDownController.pause();
    _stageController.restart();
    _stageController.pause();
    changeState(TimerState.stopped);
    setStages(_stages);
  }

  pause() {
    _timer?.cancel();
    _countDownController.pause();
    _stageController.pause();
    changeState(TimerState.paused);
  }

  finish() {
    _timer?.cancel();
    changeState(TimerState.done);
  }
}

enum TimerState { beforePlay, playing, paused, stopped, done }

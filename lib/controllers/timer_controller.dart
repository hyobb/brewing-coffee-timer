import 'dart:async';
import 'dart:ffi';
import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Duration _totalElapsedDuration = new Duration(minutes: 0, seconds: 0);
  Duration _currentDuration = new Duration(minutes: 0, seconds: 0);
  Duration _totalDuration = new Duration(minutes: 0, seconds: 0);
  int _currentStageIndex = 0;
  Stage? _currentStage;
  List<Stage> _stages = [];
  Timer? _timer;

  get stages => _stages;
  get totalElapsedTime => format(_totalElapsedDuration);
  get currentElapsedTime => format(_currentDuration);
  get totalTime => format(_totalDuration);
  get currentStageTitle => _currentStage?.title;

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
    update();
  }

  start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentDuration = _currentDuration + Duration(seconds: 1);
      _totalElapsedDuration = _totalElapsedDuration + Duration(seconds: 1);

      if (_currentDuration == _currentStage?.duration) {
        _currentDuration = Duration(seconds: 0);
        _currentStageIndex++;
        _currentStage = stages[_currentStageIndex];
      } else {}

      if (_totalElapsedDuration == _totalDuration) {
        stop();
      }

      update();
    });
  }

  stop() {
    _timer?.cancel();
    update();
  }

  goNext format(Duration d) => d.toString().substring(2, 7);
}

import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  final timerController = Get.put(TimerController());
  String _currentTitle = '';
  Duration _currentDuration = new Duration(minutes: 1, seconds: 0);
  List<Stage> _stages = [
    Stage(1, '뜸', Duration(seconds: 3)),
    Stage(2, '1차 추출', Duration(seconds: 3)),
    Stage(3, '2차 추출', Duration(seconds: 3))
  ];
  Stage? _currentStage;
  get stages => _stages;
  get currentStage => _currentStage;

  @override
  onInit() {
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
  }

  addStage() {
    var order = (_stages.length + 1);
    _stages.add(new Stage(order, _currentTitle, _currentDuration));
    // resetCurrentData();
    update();
  }

  setCurrentTitle(String title) {
    _currentTitle = title;
  }

  setCurrentDuration(Duration duration) {
    _currentDuration = duration;
  }

  resetCurrentData() {
    _currentDuration = new Duration(minutes: 1, seconds: 0);
    _currentTitle = '';
  }

  setCurrentStage(int order) {
    print('setcurrent!!');
    _currentStage = _stages[order - 1];
    setCurrentTitle(_currentStage!.title);
    _currentDuration = _currentStage!.duration;
    print(_currentStage!.title);
    timerController.setStages(_stages);
    update();
  }

  getCurrentTitle() {
    if (_currentStage == null) {
      return '';
    } else {
      return _currentStage!.title;
    }
  }

  updateCurrentStage() {
    if (_currentStage == null) {
      return;
    }
    int order = _currentStage!.order;
    Stage _stage = Stage(order, _currentTitle, _currentDuration);
    _stages.replaceRange(order - 1, order, [_stage]);
    _currentStage = null;
    timerController.setStages(_stages);
    update();
  }
}

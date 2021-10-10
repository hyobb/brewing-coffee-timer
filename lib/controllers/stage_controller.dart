import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  String _currentTitle = '';
  Duration _currentDuration = new Duration(minutes: 1, seconds: 0);
  List<Stage> _stages = [];
  get stages => _stages;

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
}

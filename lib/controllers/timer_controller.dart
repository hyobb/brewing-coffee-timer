import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  List<Stage> _stages = [];

  void addStage(String title, Duration duration) {
    _stages.add(new Stage(title, duration));
    update();
  }
}

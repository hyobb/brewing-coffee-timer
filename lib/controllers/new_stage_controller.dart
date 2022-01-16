import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewStageController extends GetxController {
  late Stage _stage;

  @override
  void onInit() {
    resetStage();
    super.onInit();
  }

  Stage get stage => _stage;

  resetStage() {
    setStage(Stage(0, '', Duration(minutes: 1)));
    update();
  }

  setStage(Stage stage) {
    _stage = stage;
    update();
  }

  setTitle(String title) {
    _stage.setTitle = title;
    update();
  }

  setDuration(Duration duration) {
    _stage.setDuration = duration;
    update();
  }
}

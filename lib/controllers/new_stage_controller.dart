import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewStageController extends GetxController {
  late StageVO _stageVO;

  @override
  void onInit() {
    resetStage();
    super.onInit();
  }

  StageVO get stageVO => _stageVO;

  resetStage() {
    setStage(StageVO(0, '', Duration(minutes: 1)));
    update();
  }

  setStage(StageVO stageVO) {
    _stageVO = stageVO;
    update();
  }

  setTitle(String title) {
    _stageVO.setTitle = title;
    update();
  }

  setDuration(Duration duration) {
    _stageVO.setDuration = duration;
    update();
  }
}

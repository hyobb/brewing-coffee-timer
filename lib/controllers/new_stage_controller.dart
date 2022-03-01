import 'package:brewing_coffee_timer/models/stageVO.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewStageController extends GetxController {
  late StageVO _stageVO;
  int? _index;

  get index => _index;
  StageVO get stageVO => _stageVO;

  @override
  void onInit() {
    resetStage();
    super.onInit();
  }

  resetStage() {
    setStage(StageVO(0, 0, '', Duration(minutes: 1)), null);
    _index = null;
    update();
  }

  setStage(StageVO stageVO, int? index) {
    _stageVO = stageVO;
    _index = index;
    update();
  }

  setTitle(String title) {
    _stageVO.title = title;
    update();
  }

  setDuration(Duration duration) {
    _stageVO.duration = duration;
    update();
  }
}

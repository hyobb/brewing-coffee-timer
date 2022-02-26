import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/data/database.dart';
import 'package:brewing_coffee_timer/main.dart';
import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  final timerController = Get.put(TimerController());
  String _currentTitle = '';
  Duration _currentDuration = new Duration(minutes: 1, seconds: 0);
  List<StageVO> _stageVOs = [
    // Stage(1, '뜸', Duration(seconds: 3)),
    // Stage(2, '1차 추출', Duration(seconds: 3)),
    // Stage(3, '2차 추출', Duration(seconds: 3))
  ];
  StageVO? _currentStageVO;
  get stageVOs => _stageVOs;
  get currentStageVO => _currentStageVO;
  AppDatabase db = appDatabase;

  @override
  onReady() {
    super.onReady();

    _getAllStages();
  }

  @override
  onInit() {
    super.onInit();
    print(_stageVOs);
  }

  @override
  onClose() {
    super.onClose();
  }

  addStage() {
    var order = (_stageVOs.length + 1);
    _stageVOs.add(new StageVO(order, _currentTitle, _currentDuration));
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
    _currentStageVO = _stageVOs[order - 1];
    setCurrentTitle(_currentStageVO!.title);
    _currentDuration = _currentStageVO!.duration;
    print(_currentStageVO!.title);
    timerController.setStages(_stageVOs);
    update();
  }

  getCurrentTitle() {
    if (_currentStageVO == null) {
      return '';
    } else {
      return _currentStageVO!.title;
    }
  }

  updateCurrentStage() {
    if (_currentStageVO == null) {
      return;
    }
    int order = _currentStageVO!.order;
    StageVO _stage = StageVO(order, _currentTitle, _currentDuration);
    _stageVOs.replaceRange(order - 1, order, [_stage]);
    _currentStageVO = null;
    timerController.setStages(_stageVOs);
    update();
  }

  _getAllStages() {
    db.stageDao.getAll().then((stageDataList) {
      _stageVOs = stageDataList
          .map((data) =>
              StageVO(data.order, data.title, Duration(seconds: data.second)))
          .toList();
    });

    update();
  }
}

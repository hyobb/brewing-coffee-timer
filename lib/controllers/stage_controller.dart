import 'package:brewing_coffee_timer/controllers/timer_controller.dart';
import 'package:brewing_coffee_timer/data/database.dart';
import 'package:brewing_coffee_timer/main.dart';
import 'package:brewing_coffee_timer/models/stageVO.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  String _currentTitle = '';
  Duration _currentDuration = new Duration(minutes: 1, seconds: 0);
  RxList<StageVO> _stageVOs = RxList<StageVO>();
  StageVO? _currentStageVO;
  RxList<StageVO> get stageVOs => _stageVOs;

  get currentStageVO => _currentStageVO;
  AppDatabase db = appDatabase;

  @override
  onReady() {
    super.onReady();
  }

  @override
  onInit() {
    super.onInit();
    _getAllStages();
  }

  @override
  onClose() {
    super.onClose();
  }

  addStage(StageVO stageVO) {
    var order = (_stageVOs.length + 1);
    var stageCompanion = StageCompanion(
        order: drift.Value(order),
        title: drift.Value(stageVO.title),
        second: drift.Value(stageVO.duration.inSeconds));

    db.stageDao.insertStage(stageCompanion).then((stageData) {
      _stageVOs.add(
          new StageVO(stageData.id, order, stageVO.title, stageVO.duration));
      update();
    });
  }

  updateStage(int? index, StageVO updateStageVO) {
    if (index == null) {
      return;
    }

    var stageVO = _stageVOs[index];

    StageVO newStageVO = StageVO(stageVO.id, updateStageVO.order,
        updateStageVO.title, updateStageVO.duration);
    _stageVOs.replaceRange(index, index + 1, [newStageVO]);

    print('update!!');
    print(index);
    print(newStageVO.title);
    print(newStageVO.duration);

    db.stageDao.updateStage(StageCompanion(
        id: drift.Value(newStageVO.id),
        title: drift.Value(newStageVO.title),
        second: drift.Value(newStageVO.duration.inSeconds),
        order: drift.Value(newStageVO.order)));

    update();
  }

  deleteStage(int index) {
    var stageVO = _stageVOs[index];

    if (stageVO == null) {
      return;
    }

    _stageVOs.removeAt(index);
    db.stageDao.deleteStage(stageVO.id);
    update();
  }

  _getAllStages() {
    db.stageDao.getAll().then((stageDataList) {
      _stageVOs.value = stageDataList
          .map((data) => StageVO(
                data.id,
                data.order,
                data.title,
                Duration(seconds: data.second),
              ))
          .toList();
      update();
    });
  }
}

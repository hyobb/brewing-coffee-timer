import 'package:brewing_coffee_timer/models/stage.dart';
import 'package:brewing_coffee_timer/widgets/new_stage_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Get.bottomSheet(Container(
              color: Colors.white,
              height: 300,
              child: NewStageWidget(),
            ));
          }),
    );
  }

  // String textToShow = "Hello world";

  // void _updateText() {
  //   setState(() {
  //     textToShow = "HIHI";
  //   });
  // }

  Widget _body() {
    return Column(children: [TimerWidget(), StageListWidget()]);
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.blueAccent),
          child: Column(
            children: <Widget>[
              Text(
                "총 경과 시간 11:11",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "현재 스테이지 11:11",
                style: TextStyle(fontSize: 40),
              ),
              Text(
                "스테이지 이름",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.green,
                textColor: Colors.greenAccent,
                child: Icon(
                  Icons.stop,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.green,
                child: Icon(
                  Icons.play_arrow,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            ],
          ),
          padding: EdgeInsets.only(right: 30, left: 30),
        ),
      ],
    );
  }
}

class StageListWidget extends StatefulWidget {
  final List<Stage> stages = [
    Stage("뜸 들이기", Duration(minutes: 1)),
    Stage("1차 추출", Duration(minutes: 1)),
    Stage("2차 추출", Duration(seconds: 40))
  ];

  // StageListWidget(this.stages);

  @override
  _StageListWidgetState createState() => _StageListWidgetState();
}

class _StageListWidgetState extends State<StageListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.stages.length,
      itemBuilder: (context, index) {
        return StageTile(widget.stages[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class StageTile extends StatefulWidget {
  final Stage stage;

  StageTile(this.stage);

  @override
  _StageTileState createState() => _StageTileState();
}

class _StageTileState extends State<StageTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("1"),
      title: Text(widget.stage.title),
      subtitle: Text(widget.stage.duration.toString()),
    );
  }
}

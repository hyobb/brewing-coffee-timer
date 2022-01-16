class Stage {
  int order;
  String title;
  Duration duration;
  bool isDone;

  Stage(this.order, this.title, this.duration, {this.isDone = false});

  set setOrder(int order) => this.order = order;
  set setTitle(String title) => this.title = title;
  set setDuration(Duration duration) => this.duration = duration;
  set setIsDone(bool idDone) => this.isDone = idDone;
}

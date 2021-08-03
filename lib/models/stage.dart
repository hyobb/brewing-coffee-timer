class Stage {
  num order;
  String title;
  Duration duration;
  bool isDone;

  Stage(this.order, this.title, this.duration, {this.isDone = false});
}

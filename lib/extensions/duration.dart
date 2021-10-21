extension DurationFormatting on Duration {
  String toCustomString() {
    return this.toString().substring(2, 7);
  }
}

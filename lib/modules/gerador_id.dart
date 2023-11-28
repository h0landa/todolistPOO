String gerarId() {
  DateTime now = DateTime.now();

  String timestamp = now.microsecondsSinceEpoch.toString();

  return timestamp;
}

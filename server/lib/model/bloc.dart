class Bloc {
  DateTime timestamp;
  String lastHash;
  String hash;
  String data;
  int nounce;
  int difficulty;

  Bloc({this.timestamp, this.lastHash, this.hash, this.data, this.nounce, this.difficulty});

}
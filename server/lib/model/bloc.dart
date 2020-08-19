import 'package:json_annotation/json_annotation.dart';
part 'bloc.g.dart';

@JsonSerializable()
class Bloc {
  DateTime timestamp;
  String lastHash;
  String hash;
  String data;
  int nounce;
  int difficulty;

  Bloc({
    this.timestamp,
      this.lastHash,
      this.hash,
      this.data,
      this.nounce,
      this.difficulty
      });

  // From generated file
  factory Bloc.fromJson(Map<String, dynamic> json) => _$BlocFromJson(json);
  Map<String, dynamic> toJson() => _$BlocToJson(this);
}

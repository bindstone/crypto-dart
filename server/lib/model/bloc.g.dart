// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bloc _$BlocFromJson(Map<String, dynamic> json) {
  return Bloc(
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    lastHash: json['lastHash'] as String,
    hash: json['hash'] as String,
    data: json['data'] as String,
    nounce: json['nounce'] as int,
    difficulty: json['difficulty'] as int,
  );
}

Map<String, dynamic> _$BlocToJson(Bloc instance) => <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'lastHash': instance.lastHash,
      'hash': instance.hash,
      'data': instance.data,
      'nounce': instance.nounce,
      'difficulty': instance.difficulty,
    };

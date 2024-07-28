// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInfo _$LogInfoFromJson(Map<String, dynamic> json) => LogInfo(
      (json['date'] as num).toInt(),
      json['message'] as String,
    );

Map<String, dynamic> _$LogInfoToJson(LogInfo instance) => <String, dynamic>{
      'date': instance.date,
      'message': instance.message,
    };

LogError _$LogErrorFromJson(Map<String, dynamic> json) => LogError(
      (json['date'] as num).toInt(),
      json['source'] as String,
      json['message'] as String,
    );

Map<String, dynamic> _$LogErrorToJson(LogError instance) => <String, dynamic>{
      'date': instance.date,
      'source': instance.source,
      'message': instance.message,
    };

PeerConnection _$PeerConnectionFromJson(Map<String, dynamic> json) =>
    PeerConnection(
      json['verifyingKey'] as String,
      (json['date'] as num).toInt(),
      json['connectionId'] as String,
    );

Map<String, dynamic> _$PeerConnectionToJson(PeerConnection instance) =>
    <String, dynamic>{
      'verifyingKey': instance.verifyingKey,
      'date': instance.date,
      'connectionId': instance.connectionId,
    };

DataModification _$DataModificationFromJson(Map<String, dynamic> json) =>
    DataModification(
      (json['rooms'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k,
                  (e as List<dynamic>).map((e) => (e as num).toInt()).toList()),
            )),
      ),
    );

Map<String, dynamic> _$DataModificationToJson(DataModification instance) =>
    <String, dynamic>{
      'rooms': instance.rooms,
    };

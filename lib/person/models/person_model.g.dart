// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonModelImpl _$$PersonModelImplFromJson(Map<String, dynamic> json) =>
    _$PersonModelImpl(
      personID: (json['personID'] as num?)?.toInt(),
      name: json['name'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      age: (json['age'] as num?)?.toInt(),
      nationalityID: (json['nationalityID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PersonModelImplToJson(_$PersonModelImpl instance) =>
    <String, dynamic>{
      'personID': instance.personID,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'age': instance.age,
      'nationalityID': instance.nationalityID,
    };

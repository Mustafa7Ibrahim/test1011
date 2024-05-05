import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_model.freezed.dart';
part 'person_model.g.dart';

@freezed
class PersonModel with _$PersonModel {
  factory PersonModel({
    int? personID,
    String? name,
    DateTime? birthDate,
    int? age,
    int? nationalityID,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);
}

extension thi on PersonModel {
  Map<String, dynamic> toCreateJson() => {
        'name': name,
        'birthDate': birthDate?.toIso8601String(),
        'age': age,
        'nationalityID': nationalityID,
      };
}

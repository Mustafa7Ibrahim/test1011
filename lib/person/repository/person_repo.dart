import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:test101/person/models/person_model.dart';

class PersonRepository {
  late Dio dio;

  PersonRepository() {
    dio = Dio();
    dio.interceptors.add(TalkerDioLogger());
  }

  final _getPersonsPath =
      "http://mohagado-001-site1.itempurl.com/Person/getAllPersons";

  final _addPersonPath =
      "http://mohagado-001-site1.itempurl.com/Person/addPerson";

  final _editPersonPath =
      "http://mohagado-001-site1.itempurl.com/Person/editPerson";

  final _deletePersonPath =
      "http://mohagado-001-site1.itempurl.com/Person/deletePerson";

  Future<List<PersonModel>> getPersons() async {
    try {
      final response = await dio.get(_getPersonsPath);
      final List<dynamic> data = response.data;
      return data.map((e) => PersonModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PersonModel> addPerson(PersonModel person) async {
    try {
      final Response response = await dio.post(
        _addPersonPath,
        data: person.toCreateJson(),
      );
      return PersonModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editPerson(PersonModel person) async {
    try {
      final Response response = await dio.post(
        _editPersonPath,
        data: person.toJson(),
      );
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deletePerson(int personId) async {
    try {
      final Response response = await dio.get(
        _deletePersonPath,
        data: {"personID": personId},
      );
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}

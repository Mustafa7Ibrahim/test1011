import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test101/person/models/person_model.dart';
import 'package:test101/person/repository/person_repo.dart';

part 'person_controller.g.dart';

@Riverpod()
class PersonController extends _$PersonController {
  @override
  Future<List<PersonModel>> build() async {
    getPersons();
    return [];
  }

  final personRepo = PersonRepository();

  void getPersons() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await personRepo.getPersons());
  }

  void addPerson(PersonModel person) async {
    await personRepo.addPerson(person);
    if (state is AsyncData) {
      final persons = state.asData!.value;
      persons.add(person);
      state = AsyncData(persons);
    }
  }

  void editPerson(PersonModel person) async {
    await personRepo.editPerson(person);
    if (state is AsyncData) {
      final persons = state.asData!.value;
      persons.removeWhere((element) => element.personID == person.personID);
      persons.add(person);
      state = AsyncData(persons);
    }
  }

  void deletePerson(int personId) async {
    // state = const AsyncValue.loading();
    final value = await personRepo.deletePerson(personId);
    // if (value) {
    if (state is AsyncData) {
      final persons = state.asData!.value;
      persons.removeWhere((element) => element.personID == personId);
      state = AsyncData(persons);
    }
    // }
  }
}

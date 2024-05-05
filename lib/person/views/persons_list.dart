import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test101/person/controller/person_controller.dart';
import 'package:test101/person/views/add_person.dart';

class PersonList extends ConsumerWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final persons = ref.watch(personControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPerson(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: persons.when(
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final person = list[index];
              return ListTile(
                title: Text(person.name ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddPerson(person: person),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(personControllerProvider.notifier)
                            .deletePerson(person.personID ?? 0);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

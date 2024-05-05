import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test101/person/controller/person_controller.dart';
import 'package:test101/person/models/person_model.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key, this.person});

  final PersonModel? person;

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  final ageController = TextEditingController();
  final ageFocusNode = FocusNode();

  final nIDController = TextEditingController();
  final nIDFocusNode = FocusNode();

  DateTime birthDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.person == null) return;
    nameController.text = widget.person!.name ?? "";
    ageController.text = widget.person!.age.toString();
    nIDController.text = widget.person!.nationalityID.toString();
    birthDate = widget.person!.birthDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: nameController,
              focusNode: nameFocusNode,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              controller: ageController,
              focusNode: ageFocusNode,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'National ID'),
              controller: nIDController,
              focusNode: nIDFocusNode,
            ),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1955),
                  lastDate: DateTime.now(),
                );
                if (date == null) return;
                setState(() => birthDate = date);
              },
              child: const Text('Select Birth Date'),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (widget.person == null) {
                      ref.read(personControllerProvider.notifier).addPerson(
                            PersonModel(
                              name: nameController.text,
                              age: int.tryParse(ageController.text) ?? 0,
                              nationalityID:
                                  int.tryParse(nIDController.text) ?? 0,
                              birthDate: birthDate,
                            ),
                          );
                    } else {
                      ref.read(personControllerProvider.notifier).editPerson(
                            PersonModel(
                              personID: widget.person!.personID,
                              name: nameController.text,
                              age: int.tryParse(ageController.text) ?? 0,
                              nationalityID:
                                  int.tryParse(nIDController.text) ?? 0,
                              birthDate: birthDate,
                            ),
                          );
                    }

                    Navigator.pop(context);
                  },
                  child: const Text('Add Person'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

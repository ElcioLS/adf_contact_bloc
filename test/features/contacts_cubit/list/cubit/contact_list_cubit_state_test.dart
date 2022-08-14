import 'package:adf_contact_bloc/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

void main() {
// declaração
  late ContactsRepository repository;
  late ContactListCubit cubit;
  late List<ContactModel> contacts;

// preparação
  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(repository: repository);

    contacts = [
      ContactModel(name: 'Elcio', email: 'elciols@gmail.com'),
      ContactModel(name: 'Elcinho', email: 'elcinho@gmail.com'),
    ];
  });
// execução

  blocTest<ContactListCubit, ContactListCubitState>(
    'Erros Buscando Lista de Contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer(
        (_) async => contacts,
      );
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );
}

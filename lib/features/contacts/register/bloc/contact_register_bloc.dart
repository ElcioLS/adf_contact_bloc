import 'dart:async';
import 'dart:developer';

import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_bloc.freezed.dart';
part 'contact_register_event.dart';
part 'contact_register_state.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactsRepository _contactsRepository;

  ContactRegisterBloc({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(ContactRegisterState.initial()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      _Save event, Emitter<ContactRegisterState> emit) async {
    try {
      emit(ContactRegisterState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contactModel = ContactModel(
        name: event.name,
        email: event.email,
      );

      await _contactsRepository.create(contactModel);
      emit(ContactRegisterState.success());
    } catch (e, s) {
      log('Erro ao salvar um novo contato', error: e, stackTrace: s);
      emit(ContactRegisterState.error(
          message: 'Erro ao salvar um novo contato'));
    }
  }
}

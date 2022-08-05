import 'dart:async';
import 'dart:developer';

import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_cubit.freezed.dart';
part 'contact_register_cubit_state.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterCubitState> {
  final ContactsRepository _repository;

  ContactRegisterCubit({required ContactsRepository repository})
      : _repository = repository,
        super(ContactRegisterCubitState.initial());

  Future<FutureOr<void>> _save(
      _Save event, Emitter<ContactRegisterCubitState> emit) async {
    try {
      emit(ContactRegisterCubitState.loading());

      await Future.delayed(const Duration(seconds: 2));

      final contactModel = ContactModel(
        name: event.name,
        email: event.email,
      );

      await _repository.create(contactModel);
      emit(ContactRegisterCubitState.success());
    } catch (e, s) {
      log('Erro ao criar contato', error: e, stackTrace: s);
      emit(ContactRegisterCubitState.error(
          message: 'Erro ao salvar um novo contato'));
    }
  }
}

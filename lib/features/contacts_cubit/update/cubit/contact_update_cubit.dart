import 'dart:async';
import 'dart:developer';

import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_cubit.freezed.dart';
part 'contact_update_cubit_state.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateCubitState> {
  final ContactsRepository _contactsRepository;

  ContactUpdateCubit({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(_Initial());
  on<_Save>(_save) {
    Future<FutureOr<void>> _save(
        event, Emitter<ContactUpdateCubitState> emit) async {
      try {
        emit(ContactUpdateCubitState.loading());
        final model = ContactModel(
          id: event.id,
          name: event.name,
          email: event.email,
        );

        await _contactsRepository.update(model);
        emit(ContactUpdateCubitState.success());
      } catch (e, s) {
        log(
          'Erro ao atualizar contato',
          error: e,
          stackTrace: s,
        );
      }
    }
  }
}

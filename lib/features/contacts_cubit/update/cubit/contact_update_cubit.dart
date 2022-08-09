import 'dart:async';
import 'dart:developer';

import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_cubit.freezed.dart';
part 'contact_update_state.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateState> {
  final ContactsRepository _repository;
  ContactUpdateCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactUpdateState.initial());

  Future<void> save(ContactModel contact) async {
    try {
      emit(const ContactUpdateState.loading());

      await _repository.update(contact);

      await Future.delayed(const Duration(seconds: 1));

      emit(const ContactUpdateState.success());
    } on Exception catch (e, s) {
      log("Erro ao atualizar contato", error: e, stackTrace: s);

      emit(
          const ContactUpdateState.error(message: "Erro ao atualizar contato"));
    }
  }
}

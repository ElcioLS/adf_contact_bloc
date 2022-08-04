import 'dart:async';
import 'dart:developer';

import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_bloc.freezed.dart';
part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepository _repository;

  ContactListBloc({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_ContactListEventDelete>(_DeleteContact);
  }

  FutureOr<void> _findAll(
    _ContactListEventFindAll event,
    Emitter<ContactListState> emit,
  ) async {
    try {
      emit(ContactListState.loading());
      final contacts = await _repository.findAll();
      await Future.delayed(const Duration(seconds: 1));
      // throw Exception();

      emit(ContactListState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar contatos', error: e, stackTrace: s);
      emit(ContactListState.error(error: 'Erro ao buscar contatos'));
    }
  }

  Future<FutureOr<void>> _DeleteContact(
      _ContactListEventDelete event, Emitter<ContactListState> emit) async {
    emit(ContactListState.loading());
    await Future.delayed(const Duration(seconds: 1));
    await _repository.delete(event.del);
    add(ContactListEvent.findAll());
  }
}

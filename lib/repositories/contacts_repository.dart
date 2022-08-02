import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://192.168.0.5:3031/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) =>
      Dio().post('http://192.168.0.5:3031/contacts', data: model.toMap());

  Future<void> update(ContactModel model) => Dio()
      .put('http://192.168.0.5:3031/contacts/${model.id}', data: model.toMap());

  Future<void> delete(ContactModel model) =>
      Dio().delete('http://192.168.0.5:3031/contacts/${model.id}');
}

import 'package:adf_contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_example.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_freezed_example.dart';
import 'package:adf_contact_bloc/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:adf_contact_bloc/features/contacts/list/contacts_list_page.dart';
import 'package:adf_contact_bloc/features/contacts/register/bloc/contact_register_bloc.dart';
import 'package:adf_contact_bloc/features/contacts/register/contact_register_page.dart';
import 'package:adf_contact_bloc/features/contacts/update/bloc/bloc/contact_update_bloc.dart';
import 'package:adf_contact_bloc/features/contacts/update/contact_update_page.dart';
import 'package:adf_contact_bloc/features/contacts_cubit/contact_list_cubit_page.dart';
import 'package:adf_contact_bloc/features/contacts_cubit/cubit/contact_list_cubit.dart';
import 'package:adf_contact_bloc/home/home_page.dart';
import 'package:adf_contact_bloc/models/contact_model.dart';
import 'package:adf_contact_bloc/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/home': (_) => const HomePage(),
          '/bloc/example/': (_) => BlocProvider(
                create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
                child: const BlocExample(),
              ),
          '/bloc/example/freezed': (context) => BlocProvider(
              create: (context) => ExampleFreezedBloc()
                ..add(const ExampleFreezedEvent.findNames()),
              child: const BlocFreezedExample()),
          '/contacts/list': (context) => BlocProvider(
              create: (_) => ContactListBloc(
                    repository: context.read<ContactsRepository>(),
                  )..add(
                      ContactListEvent.findAll(),
                    ),
              child: const ContactsListPage()),
          '/contacts/register': (context) => BlocProvider(
                create: (context) => ContactRegisterBloc(
                  contactsRepository: context.read(),
                ),
                child: const ContactRegisterPage(),
              ),
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactUpdateBloc(
                contactsRepository: context.read(),
              ),
              child: ContactUpdatePage(contact: contact),
            );
          },
          '/contacts/cubit/list': (context) {
            return BlocProvider(
              create: (context) => ContactListCubit(
                repository: context.read()..findAll(),
              ),
              child: const ContactListCubitPage(),
            );
          }
        },
      ),
    );
  }
}

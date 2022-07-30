import 'package:adf_contact_bloc/features/bloc_example/bloc/example_bloc.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_example.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:adf_contact_bloc/features/bloc_example/bloc_freezed_example.dart';
import 'package:adf_contact_bloc/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}

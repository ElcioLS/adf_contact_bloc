import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            const Card(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bloc/example/');
              },
              child: const Text('Bloc Example'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bloc/example/freezed');
              },
              child: const Text('Example freezed'),
            ),
          ],
        ),
      )),
    );
  }
}

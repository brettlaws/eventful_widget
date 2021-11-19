import 'package:example/random_number_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RandomNumberButton(context.read<RandomNumberBloc>()),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
      home: BlocProvider(
          create: (_) => RandomNumberBloc(
              max: 1000,
              initial: RandomNumberState(active: false, value: 1000)),
          child: Home())));
}

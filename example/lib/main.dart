import 'package:example/random_color_button.dart';
import 'package:example/random_number_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RandomNumberButton(context.read<RandomNumberBloc>()),
            RandomColorButton(context.read<RandomColorBloc>()),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RandomNumberBloc(
              max: 1000,
              initial: RandomNumberState(active: false, value: 1000)),
        ),
        BlocProvider(create: (_) => RandomColorBloc()),
      ],
      child: Home(),
    ),
  ));
}

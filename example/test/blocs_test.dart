import 'package:example/random_color_button.dart';
import 'package:example/random_number_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> addEvent<E>(Bloc bloc, E event) async {
  bloc.add(event);
  await Future.delayed(Duration(milliseconds: 100));
}

void main() {
  group('Random number bloc', () {
    late RandomNumberBloc randomNumberBloc;

    setUp(() {
      randomNumberBloc = RandomNumberBloc();
    });

    test('initial state is inactive, 0', () {
      expect(randomNumberBloc.state.active, false);
      expect(randomNumberBloc.state.value, 0);
    });

    test('value doesn\'t change if inactive', () async {
      await addEvent(randomNumberBloc, RandomNumberEvent.generate);
      expect(randomNumberBloc.state.value, 0);
    });

    test('activate', () async {
      await addEvent(randomNumberBloc, RandomNumberEvent.activate);
      await Future.delayed(Duration(milliseconds: 100));
      expect(randomNumberBloc.state.active, true);
    });

    test('value changes if active', () async {
      await addEvent(randomNumberBloc, RandomNumberEvent.activate);
      await addEvent(randomNumberBloc, RandomNumberEvent.generate);
      await Future.delayed(Duration(milliseconds: 400));
      final int a = randomNumberBloc.state.value;
      await addEvent(randomNumberBloc, RandomNumberEvent.generate);
      await Future.delayed(Duration(milliseconds: 400));
      final int b = randomNumberBloc.state.value;
      print('a: $a\tb: $b');
      expect(a != b, true);
    });
  });

  group('Random number bloc', () {
    late RandomColorBloc randomColorBloc;

    setUp(() {
      randomColorBloc = RandomColorBloc();
    });

    test('initial state is blue', () {
      expect(randomColorBloc.state.color, Colors.grey);
    });

    test('color is not blue after activating', () async {
      await addEvent(randomColorBloc, RandomColorEvent.activate);
      await Future.delayed(Duration(milliseconds: 400));
      expect(randomColorBloc.state.color == Colors.grey, false);
    });
  });
}

import 'dart:async';
import 'dart:math';

import 'package:bloc_widget/bloc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RandomColorEvent {
  activate,
  deactivate,
  generate,
}

class RandomColorState {
  RandomColorState({required this.active, required this.color});

  final bool active;
  final Color color;
}

class RandomColorBloc extends Bloc<RandomColorEvent, RandomColorState> {
  RandomColorBloc()
      : super(RandomColorState(active: false, color: Colors.grey)) {
    on<RandomColorEvent>((event, emit) {
      switch (event) {
        case RandomColorEvent.activate:
          if (!state.active) {
            emit(RandomColorState(active: true, color: state.color));
            timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
              add(RandomColorEvent.generate);
            });
          }
          break;
        case RandomColorEvent.deactivate:
          if (state.active) {
            timer?.cancel();
            emit(RandomColorState(active: false, color: state.color));
          }
          break;
        case RandomColorEvent.generate:
          if (state.active) {
            final newColor = Color.fromARGB(
                Random().nextInt(256),
                Random().nextInt(256),
                Random().nextInt(256),
                Random().nextInt(256));
            emit(RandomColorState(active: state.active, color: newColor));
          }
          break;
        default:
      }
    });
  }

  Timer? timer;
}

class RandomColorButton extends BlocWidget<RandomColorEvent, RandomColorState> {
  RandomColorButton(Bloc<RandomColorEvent, RandomColorState> bloc)
      : super(bloc);

  @override
  StateInjectedWidget<RandomColorEvent, RandomColorState> builder(
          BuildContext context,
          RandomColorState state,
          Function(RandomColorEvent)? onEvent) =>
      RandomColorButtonView(state, onEvent);
}

class RandomColorButtonView
    extends StateInjectedWidget<RandomColorEvent, RandomColorState> {
  RandomColorButtonView(
      RandomColorState state, Function(RandomColorEvent)? onEvent)
      : super(state, onEvent: onEvent);

  @override
  Widget builder(BuildContext context, RandomColorState state,
      void Function(RandomColorEvent)? onEvent) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: state.color),
        onPressed: () => onEvent!(state.active
            ? RandomColorEvent.deactivate
            : RandomColorEvent.activate),
        child: Text('   '));
  }
}

import 'dart:async';
import 'dart:math';

import 'package:eventful_widget/eventful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RandomNumberEvent {
  generate,
  deactivate,
  activate,
}

class RandomNumberState {
  RandomNumberState({required this.active, required this.value});
  final bool active;
  final int value;
}

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  RandomNumberBloc({this.max = 1000, RandomNumberState? initial})
      : super(initial ?? RandomNumberState(active: false, value: 0)) {
    print('Created new RandomNumberBloc');
    on<RandomNumberEvent>((event, emit) {
      switch (event) {
        case RandomNumberEvent.generate:
          if (state.active) {
            emit(RandomNumberState(
                active: state.active, value: (Random().nextInt(max)).toInt()));
          }
          break;
        case RandomNumberEvent.activate:
          if (!state.active) {
            emit(RandomNumberState(active: true, value: state.value));
            timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
              add(RandomNumberEvent.generate);
            });
          }
          break;
        case RandomNumberEvent.deactivate:
          if (state.active) {
            timer?.cancel();
            emit(RandomNumberState(active: false, value: state.value));
          }
          break;
        default:
      }
    });
  }

  final int max;
  Timer? timer;
}

class RandomNumberButtonView
    extends StateInjectedWidget<RandomNumberEvent, RandomNumberState> {
  RandomNumberButtonView(
      {required RandomNumberState state, Function(RandomNumberEvent)? onEvent})
      : super(state, onEvent: onEvent);

  @override
  Widget builder(BuildContext context, RandomNumberState state,
      Function(RandomNumberEvent)? onEvent) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: state.active ? Colors.blue : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          if (state.active) {
            onEvent!(RandomNumberEvent.deactivate);
          } else {
            onEvent!(RandomNumberEvent.activate);
          }
        },
        child: Text(state.value.toString()));
  }
}

class RandomNumberButton
    extends EventfulWidget<RandomNumberEvent, RandomNumberState> {
  RandomNumberButton(RandomNumberBloc bloc) : super(bloc);

  @override
  StateInjectedWidget<RandomNumberEvent, RandomNumberState> builder(
          BuildContext context,
          RandomNumberState state,
          Function(RandomNumberEvent)? onEvent) =>
      RandomNumberButtonView(
        state: state,
        onEvent: onEvent,
      );
}

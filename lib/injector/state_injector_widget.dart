import 'package:flutter/widgets.dart';

abstract class StateInjectedWidget<E, S> extends StatelessWidget {
  StateInjectedWidget(this.state, {this.onEvent, Key? key}) : super(key: key);

  final S state;
  final void Function(E)? onEvent;

  Widget builder(BuildContext context, S state, void Function(E)? onEvent);

  @override
  Widget build(BuildContext context) {
    return builder(context, state, onEvent);
  }
}

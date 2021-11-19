library bloc_widget;

export 'injector/state_injector_widget.dart';

import 'package:bloc_widget/injector/state_injector_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocWidget<E, S> extends StatelessWidget {
  BlocWidget(this.bloc);

  final Bloc<E, S> bloc;

  StateInjectorWidget<E, S> builder(
      BuildContext context, S state, Function(E)? onEvent);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBase<S>, S>(
      bloc: bloc,
      builder: (context, state) =>
          builder(context, state, (event) => bloc.add(event)),
    );
  }
}

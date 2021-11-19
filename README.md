
# bloc_widget

  

A Flutter package that uses bloc to encourage separation of logic from looks.

  

# Usage

  

Start by defining your <b>events</b> and <b>states</b>.
```dart
enum  CoolEvent {
	somethingCool,
	somethingEvenCooler,
}

@immutable
class  CoolState {
	CoolState(this.message);
	final  String  message;
}
```
With these, we can now create our BLoC.
```dart
class CoolBloc extends Bloc<CoolEvent, CoolState> {}
```
Let's go ahead and add some logic to the constructor of our bloc.
```dart
class  CoolBloc  extends  Bloc<CoolEvent, CoolState> {
	CoolBloc() : super(CoolState('waiting for something cool to happen...')) {
		on<CoolEvent>((event, emit) {
			String  message = '';
			switch (event) {
				case  CoolEvent.somethingCool:
				message = 'waiting for something cool to happen...';
				break;
				case  CoolEvent.somethingEvenCooler:
				message = 'something REALLY cool happened!';
				break;
				default:
				message = 'this shouldn\'t ever happen';
			}
			emit(CoolState(message)); // this is what triggers state change in your widget
		});
	}
}
```  

Next, create a widget which will use your new bloc and delegate drawing by extending <b>BlocWidget</b> and implementing <b>builder</b>.

  

```dart
class  CoolWidget  extends  BlocWidget<CoolEvent, CoolState> {
	CoolWidget(Bloc<CoolEvent, CoolState> bloc) : super(bloc);
	
	@override
	StateInjectedWidget<CoolEvent, CoolState> builder(BuildContext  context, CoolState  state, void Function(CoolEvent)? onEvent) => CoolWidgetView(state, onEvent);
}
```

Finally, it's time to create the widget that will actually "draw" your UI.  Make sure to extend <b>StateInjectedWidget</b>.
```dart
class  CoolWidgetView  extends  StateInjectedWidget<CoolEvent, CoolState> {
	CoolWidgetView(CoolState  state, void  Function(CoolEvent)? onEvent) : super(state, onEvent: onEvent);

	@override
	Widget  builder(BuildContext  context, CoolState  state, void  Function(CoolEvent)? onEvent) {
		return  ElevatedButton(
		onPressed: () {
			if (state.message == 'waiting for something cool to happen...') {
			onEvent!(CoolEvent.somethingEvenCooler);
			} else {
			onEvent!(CoolEvent.somethingCool);
			}
		},
		child: Text(state.message),
		);
	}
}
```
Now you can use <b>CoolWidget</b> like so:
```dart
void main() {
	final bloc = CoolBloc();
	
	runApp(MaterialApp(
		home: Center(
		child: CoolWidget(bloc),
	));
}
```
import 'package:example/random_color_button.dart';
import 'package:example/random_number_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RandomNumberView', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: RandomNumberButtonView(
            state: RandomNumberState(active: false, value: 1000),
            onEvent: (e) {
              expect(e, RandomNumberEvent.activate);
            },
          ))),
    ));
    expect(find.text('1000'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: RandomNumberButtonView(
            state: RandomNumberState(active: true, value: 555),
            onEvent: (e) {
              expect(e, RandomNumberEvent.deactivate);
            },
          ))),
    ));
    expect(find.text('555'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
  });
}

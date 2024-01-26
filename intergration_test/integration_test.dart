import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/Modules/Todo/Screens/todo_screen.dart';
import 'package:weather_app/Modules/screens/home_page.dart';
import 'package:weather_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('EtoE', () {
    testWidgets('input', (tester) async {
      await tester.pumpWidget(const app.MyApp());

      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byKey(const Key('input_name')), 'ying');
      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(find.byKey(const Key('input_gender')), 'femail');
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('tap_add')));
      // await tester.pumpWidget(const app.MyApp());
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('edit')));
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byKey(const Key('input_name')), 'Em Syying');
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byKey(const Key('input_gender')), 'Femail');

      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('tap_add')));
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('remove')));
      await Future.delayed(const Duration(seconds: 4));
      await tester.tap(find.byKey(const Key('gohome')));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(find.byType(TodoScreen), findsOneWidget);
    });
  });
}

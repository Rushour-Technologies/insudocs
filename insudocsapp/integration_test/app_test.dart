import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insudox_app/login_signup/login.dart';
import 'package:insudox_app/login_signup/signup.dart';
import 'package:integration_test/integration_test.dart';
import 'package:insudox_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  group('Authentication Tests', () {
    testWidgets('Test Login', (tester) async {
      app.testMain(const Login());
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.

      final textFields = find.byType(TextFormField);
      // final passwordTextField = find.text('Password');
      final continueButton = find.text('CONTINUE');

      expect(textFields.first, findsOneWidget);
      expect(textFields, findsWidgets);

      await tester.enterText(textFields.at(0), 'mewo@gmail.com');
      await tester.enterText(textFields.at(1), 'confjirm');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await wait(2);
      await tester.tap(continueButton);
      await wait(2);
    });

    print('Test Login Successful');
    testWidgets('Test Signup', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Signup()));

      await Future.delayed(const Duration(seconds: 2));

      // Verify the counter starts at 0.

      final textFields = find.byType(TextFormField);

      final continueButton = find.text('CONTINUE');

      expect(textFields.first, findsOneWidget);
      expect(textFields, findsWidgets);

      await tester.enterText(textFields.at(0), 'New User');
      await tester.enterText(textFields.at(1), 'newuser@gmail.com');
      await tester.enterText(textFields.at(2), 'password');
      await tester.enterText(textFields.last, 'password');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await wait(2);
      await tester.tap(continueButton);
      await wait(2);
    });
    print('Test Signup Successful');
  });
}

Future<void> wait(int num) async {
  await Future.delayed(Duration(seconds: num));
}

import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Auth Page',
    () {
      testWidgets('Register form input and tap Sign Up button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: RegisterPage(),
          ),
        );

        final nameField = find.byWidgetPredicate((widget) => widget is Input && widget.label == 'Name');
        final emailField = find.byWidgetPredicate((widget) => widget is Input && widget.label == 'Email');
        final passwordField = find.byWidgetPredicate((widget) => widget is InputPassword && widget.label == 'Password');
        final registerButton = find.byType(Button);

        await tester.enterText(nameField, 'Test User');
        await tester.enterText(emailField, 'test_register@example.com');
        await tester.enterText(passwordField, 'register123');

        await tester.tap(registerButton);
        await tester.pump();

        expect(nameField, findsOneWidget);
        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(registerButton, findsOneWidget);
      });

      testWidgets('Login form input and tap Log In button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginPage(),
          ),
        );

        final emailField = find.byWidgetPredicate((widget) => widget is Input && widget.label == 'Email');
        final passwordField = find.byWidgetPredicate((widget) => widget is InputPassword && widget.label == 'Password');

        final loginButton = find.byType(Button);

        await tester.enterText(emailField, 'test_login@example.com');
        await tester.enterText(passwordField, 'password123');

        await tester.tap(loginButton);
        await tester.pump();

        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(loginButton, findsOneWidget);
      });
    },
  );
}

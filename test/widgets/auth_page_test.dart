import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:fe_catat_uangku/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Auth Page',
    () {
      testWidgets('Register form input and tap Sign Up button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: AuthPage(),
          ),
        );

        final signUpTab = find.widgetWithText(TextButton, 'Sign Up');
        await tester.tap(signUpTab);
        await tester.pumpAndSettle();

        final nameField = find.byWidgetPredicate(
          (widget) => widget is CustomTextForm && widget.labelText == 'Name',
        );

        final emailField = find.byWidgetPredicate(
          (widget) => widget is CustomTextForm && widget.labelText == 'Email',
        );

        final passwordField = find.byWidgetPredicate(
          (widget) => widget is CustomTextForm && widget.labelText == 'Password',
        );

        final signUpButton = find.widgetWithText(ElevatedButton, 'Sign Up');

        await tester.enterText(nameField, 'Test User');
        await tester.enterText(emailField, 'test_register@example.com');
        await tester.enterText(passwordField, 'register123');

        await tester.tap(signUpButton);
        await tester.pump();

        expect(nameField, findsOneWidget);
        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(signUpButton, findsOneWidget);
      });

      testWidgets('Login form input and tap Log In button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: AuthPage(),
          ),
        );

        final emailField = find.byWidgetPredicate(
          (widget) => widget is CustomTextForm && widget.labelText == 'Email',
        );

        final passwordField = find.byWidgetPredicate(
          (widget) => widget is CustomTextForm && widget.labelText == 'Password',
        );

        final loginButton = find.widgetWithText(ElevatedButton, 'Log In');

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

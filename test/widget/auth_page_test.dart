import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:fe_catat_uangku/widgets/custom_elevated_button.dart';
import 'package:fe_catat_uangku/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthPage Widget Tests', () {
    testWidgets('AuthPage menampilkan form login secara default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthPage(),
        ),
      );

      expect(find.text('Log In'), findsWidgets);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot Password ?'), findsOneWidget);
    });

    testWidgets('Tombol Sign Up menampilkan form register', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AuthPage()));

      // Tekan tombol Sign Up
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Sign Up'), findsWidgets); // dua: tombol & judul
    });

testWidgets('Input login dapat diisi dan tombol Log In bisa ditekan', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: AuthPage()));

  // Temukan input email dan password di login
  final emailField = find.descendant(
    of: find.byWidgetPredicate(
      (widget) => widget is CustomTextForm && widget.labelText == 'Email',
    ),
    matching: find.byType(TextField),
  );

  final passwordField = find.descendant(
    of: find.byWidgetPredicate(
      (widget) => widget is CustomTextForm && widget.labelText == 'Password',
    ),
    matching: find.byType(TextField),
  );

  await tester.enterText(emailField, 'user@example.com');
  await tester.enterText(passwordField, 'Password123@');

  expect(find.text('user@example.com'), findsOneWidget);
  expect(find.text('Password123@'), findsOneWidget);

  // Tap tombol login yang spesifik
  final loginButton = find.widgetWithText(CustomElevatedButton, 'Log In');
  await tester.tap(loginButton);
  await tester.pump();

  expect(loginButton, findsOneWidget);
});
  });
}

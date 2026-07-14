import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/shared/widgets/app_error.dart';

void main() {
  group('AppError', () {
    testWidgets('should display error message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppError(message: 'Something went wrong'),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('should display retry button when onRetry provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppError(
              message: 'Error',
              onRetry: () {},
            ),
          ),
        ),
      );

      expect(find.text('Tentar novamente'), findsOneWidget);
    });
  });

  group('AppEmpty', () {
    testWidgets('should display empty message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmpty(message: 'No data'),
          ),
        ),
      );

      expect(find.text('No data'), findsOneWidget);
    });

    testWidgets('should display action button when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmpty(
              message: 'No data',
              actionLabel: 'Add',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.text('Add'), findsOneWidget);
    });
  });
}

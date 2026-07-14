import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/shared/widgets/app_loading.dart';

void main() {
  group('AppLoading', () {
    testWidgets('should display CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoading(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display message when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoading(message: 'Loading data...'),
          ),
        ),
      );

      expect(find.text('Loading data...'), findsOneWidget);
    });

    testWidgets('should not display message when null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoading(),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsNothing);
    });
  });

  group('AppLoadingOverlay', () {
    testWidgets('should show child when not loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoadingOverlay(
              isLoading: false,
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show overlay when loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoadingOverlay(
              isLoading: true,
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsWidgets);
      expect(find.byType(Stack), findsWidgets);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vcardsmart/features/home/presentation/pages/home_page.dart';
import 'package:vcardsmart/features/home/presentation/widgets/home_widget.dart';

void main() {
  group('HomePage', () {
    testWidgets('should display app title in AppBar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is AppBar && widget.title != null,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display HomeWidget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.byType(HomeWidget), findsOneWidget);
    });
  });

  group('HomeWidget', () {
    testWidgets('should display credit card icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeWidget(),
          ),
        ),
      );

      expect(find.byIcon(Icons.credit_card), findsOneWidget);
    });

    testWidgets('should display title text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeWidget(),
          ),
        ),
      );

      expect(find.text('VCardSmart'), findsOneWidget);
    });

    testWidgets('should display subtitle text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomeWidget(),
          ),
        ),
      );

      expect(find.text('Digital Business Card'), findsOneWidget);
    });
  });
}

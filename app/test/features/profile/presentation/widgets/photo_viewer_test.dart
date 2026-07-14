import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/profile/presentation/widgets/photo_viewer.dart';

void main() {
  group('PhotoViewer', () {
    testWidgets('should display person icon when no photo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PhotoViewer(),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should respond to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoViewer(
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PhotoViewer));
      expect(tapped, true);
    });
  });
}

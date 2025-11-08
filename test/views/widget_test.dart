import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('Switch toggles between six-inch and footlong', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    // Read the Switch widget's current value.
    Switch sw = tester.widget<Switch>(switchFinder);
    expect(sw.value, isTrue, reason: 'Default should be footlong (true)');

    // Helper to check if any Text widget contains a substring.
    bool hasTextSubstring(String substring) {
      final texts = tester.widgetList<Text>(find.byType(Text));
      return texts.any((t) => (t.data ?? '').contains(substring));
    }

    // Initially we should see 'footlong' in the order display and not 'six-inch'.
    expect(hasTextSubstring('footlong'), isTrue);
    expect(hasTextSubstring('six-inch'), isFalse);

    // Tap the Switch to toggle.
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    // Verify the Switch value changed and the displayed type updated.
    sw = tester.widget<Switch>(switchFinder);
    expect(sw.value, isFalse, reason: 'After tap it should be six-inch (false)');

    expect(hasTextSubstring('six-inch'), isTrue);
    expect(hasTextSubstring('footlong'), isFalse);
  });
}

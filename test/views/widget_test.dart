import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.textContaining('0'), findsWidgets);
    });

    testWidgets('increments quantity when Add is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      expect(find.textContaining('1'), findsWidgets);
    });

    testWidgets('decrements quantity when Remove is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      expect(find.textContaining('0'), findsWidgets);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      expect(find.textContaining('0'), findsWidgets);
    });

    testWidgets('does not increment above maxQuantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
        await tester.pump();
      }
      expect(find.textContaining('5'), findsWidgets);
    });
  });

  group('OrderScreen - Size Switch', () {
    testWidgets('toggles between footlong and six-inch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.text('footlong'), findsOneWidget);
      expect(find.text('six-inch'), findsOneWidget);
      
      await tester.tap(find.byType(Switch).first);
      await tester.pump();

      expect(find.text('footlong'), findsOneWidget);
      expect(find.text('six-inch'), findsOneWidget);
    });
  });

  group('OrderScreen - Toast Switch', () {
    testWidgets('toggles between untoasted and toasted',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.text('untoasted'), findsOneWidget);
      expect(find.text('toasted'), findsOneWidget);
      
      await tester.tap(find.byType(Switch).at(1));
      await tester.pump();

      expect(find.text('untoasted'), findsOneWidget);
      expect(find.text('toasted'), findsOneWidget);
    });
  });

  group('OrderScreen - Notes', () {
    testWidgets('updates note with TextField', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.enterText(find.byKey(const Key('notes_textfield')), 'Extra mayo');
      await tester.pump();
      expect(find.text('Note: Extra mayo'), findsOneWidget);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('OrderItemDisplay', () {
    testWidgets('displays order item information', (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 2,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'Extra mayo',
        isToasted: false,
        totalPrice: 15.99,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.byType(OrderItemDisplay), findsOneWidget);
      expect(find.text('Note: Extra mayo'), findsOneWidget);
    });

    testWidgets('shows emoji for sandwiches', (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 3,
        itemType: 'footlong',
        breadType: BreadType.wheat,
        orderNote: 'No notes',
        isToasted: true,
        totalPrice: 20.99,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.byType(OrderItemDisplay), findsOneWidget);
      expect(find.textContaining('🥪🥪🥪'), findsOneWidget);
    });

    testWidgets('displays price information', (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 1,
        itemType: 'six-inch',
        breadType: BreadType.wholemeal,
        orderNote: 'Light lettuce',
        isToasted: false,
        totalPrice: 8.50,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.byType(OrderItemDisplay), findsOneWidget);
      expect(find.textContaining('8.50'), findsOneWidget);
    });

    testWidgets('displays toasted state', (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'No notes',
        isToasted: true,
        totalPrice: 11.0,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.textContaining('toasted'), findsOneWidget);
    });
  });

  group('BreadType Enum', () {
    test('BreadType has required values', () {
      expect(BreadType.white, isNotNull);
      expect(BreadType.wheat, isNotNull);
      expect(BreadType.wholemeal, isNotNull);
    });
  });
}

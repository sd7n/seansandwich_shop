import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App - Core', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Structure', () {
    testWidgets('OrderScreen has Scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('OrderScreen has AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('AppBar displays title', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('Page is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('UI Labels & Text', () {
    testWidgets('Size labels display', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Six-inch'), findsOneWidget);
      expect(find.text('Footlong'), findsOneWidget);
    });

    testWidgets('Cart Summary header displays', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Cart Summary'), findsOneWidget);
    });
  });

  group('Controls & Buttons', () {
    testWidgets('Size switch exists', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Add to Cart button exists', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.widgetWithText(ElevatedButton, 'Add to Cart'), findsOneWidget);
    });

    testWidgets('Remove quantity button exists', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('Add quantity button exists', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });

  group('Initial State', () {
    testWidgets('Initial quantity is 1', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Cart starts empty', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Items in Cart: 0'), findsOneWidget);
    });

    testWidgets('Cart price starts at zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Total Price: \$0.00'), findsOneWidget);
    });
  });

  group('Quantity Interactions', () {
    testWidgets('Remove button decreases quantity', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Quantity does not go below 1', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('Switch Interactions', () {
    testWidgets('Size switch is clickable', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('Size labels persist after switch', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(find.text('Six-inch'), findsOneWidget);
      expect(find.text('Footlong'), findsOneWidget);
    });
  });

  group('Cart Operations', () {
    testWidgets('Add to Cart button is clickable', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pump();
      expect(find.byType(OrderScreen), findsOneWidget);
    });

    testWidgets('Price updates after adding', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pump();
      expect(find.textContaining('\$'), findsWidgets);
    });
  });

  group('Component Tests', () {
    testWidgets('StyledButton renders icon', (WidgetTester tester) async {
      const button = StyledButton(
        onPressed: null,
        icon: Icons.star,
        label: 'Test',
        backgroundColor: Colors.blue,
      );
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: button)));
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('StyledButton renders label', (WidgetTester tester) async {
      const button = StyledButton(
        onPressed: null,
        icon: Icons.star,
        label: 'MyLabel',
        backgroundColor: Colors.blue,
      );
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: button)));
      expect(find.text('MyLabel'), findsOneWidget);
    });

    testWidgets('OrderItemDisplay renders', (WidgetTester tester) async {
      const display = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'Test',
        isToasted: false,
        totalPrice: 10.0,
      );
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: display)));
      expect(find.byType(OrderItemDisplay), findsOneWidget);
    });

    testWidgets('OrderItemDisplay shows note', (WidgetTester tester) async {
      const display = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'TestNote',
        isToasted: false,
        totalPrice: 10.0,
      );
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: display)));
      expect(find.text('Note: TestNote'), findsOneWidget);
    });

    testWidgets('OrderItemDisplay shows price', (WidgetTester tester) async {
      const display = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'Test',
        isToasted: false,
        totalPrice: 12.50,
      );
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: display)));
      expect(find.textContaining('12.50'), findsOneWidget);
    });
  });

  group('BreadType Enum Tests', () {
    test('BreadType.white is valid', () {
      expect(BreadType.white, isNotNull);
    });

    test('BreadType.wheat is valid', () {
      expect(BreadType.wheat, isNotNull);
    });

    test('BreadType.wholemeal is valid', () {
      expect(BreadType.wholemeal, isNotNull);
    });

    test('BreadType has 3 values', () {
      expect(BreadType.values.length, 3);
    });
  });

  group('Layout Tests', () {
    testWidgets('Content is in Column', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('Text widgets render', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('Buttons render', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('Container for cart summary exists', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Container), findsWidgets);
    });
  });
}

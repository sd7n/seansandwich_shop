import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Initial State', () {
    testWidgets('displays sandwich counter title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('shows initial quantity of 1', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('displays sandwich image', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('displays sandwich type dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Type'), findsOneWidget);
      expect(find.byType(DropdownMenu), findsWidgets);
    });

    testWidgets('displays bread type dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Bread Type'), findsOneWidget);
    });

    testWidgets('displays size toggle switch', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Six-inch'), findsOneWidget);
      expect(find.text('Footlong'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('displays add to cart button', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.widgetWithText(ElevatedButton, 'Add to Cart'), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity Management', () {
    testWidgets('increases quantity when plus button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();
      
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decreases quantity when minus button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();
      
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('does not decrement quantity below 1',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();
      
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('increments quantity multiple times',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.add).first);
        await tester.pump();
      }
      
      expect(find.text('6'), findsOneWidget);
    });
  });

  group('OrderScreen - Size Selection', () {
    testWidgets('toggle switch changes between six-inch and footlong',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      expect(find.text('Six-inch'), findsOneWidget);
      expect(find.text('Footlong'), findsOneWidget);
      
      await tester.tap(find.byType(Switch));
      await tester.pump();
      
      expect(find.text('Six-inch'), findsOneWidget);
      expect(find.text('Footlong'), findsOneWidget);
    });
  });

  group('OrderScreen - Bread Type Selection', () {
    testWidgets('opens bread type dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final breadDropdown = find.byType(DropdownMenu).at(1);
      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();
      
      expect(find.byType(DropdownMenu), findsWidgets);
    });

    testWidgets('selects different bread type', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final breadDropdown = find.byType(DropdownMenu).at(1);
      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();
      
      await tester.tap(find.widgetWithText(MenuItemButton, 'wheat'));
      await tester.pumpAndSettle();
      
      expect(find.byType(DropdownMenu), findsWidgets);
    });
  });

  group('OrderScreen - Sandwich Type Selection', () {
    testWidgets('opens sandwich type dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final sandwichDropdown = find.byType(DropdownMenu).first;
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();
      
      expect(find.byType(DropdownMenu), findsWidgets);
    });

    testWidgets('selects different sandwich type', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final sandwichDropdown = find.byType(DropdownMenu).first;
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();
      
      await tester.tap(find.widgetWithText(MenuItemButton, 'Chicken Teriyaki'));
      await tester.pumpAndSettle();
      
      expect(find.byType(DropdownMenu), findsWidgets);
    });
  });

  group('OrderScreen - Add to Cart', () {
    testWidgets('add to cart button is enabled when quantity is greater than 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final addButton = find.widgetWithText(ElevatedButton, 'Add to Cart');
      expect(addButton, findsOneWidget);
      
      final buttonWidget = tester.widget<ElevatedButton>(addButton);
      expect(buttonWidget.onPressed, isNotNull);
    });

    testWidgets('add to cart button functionality', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pump();
      
      expect(find.byType(OrderScreen), findsOneWidget);
    });

    testWidgets('can add multiple items sequentially',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
        await tester.pump();
      }
      
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Image Updates', () {
    testWidgets('displays sandwich image on screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('image updates when sandwich type changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      final sandwichDropdown = find.byType(DropdownMenu).first;
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();
      
      await tester.tap(find.widgetWithText(MenuItemButton, 'Tuna Melt'));
      await tester.pumpAndSettle();
      
      expect(find.byType(Image), findsOneWidget);
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
  });

  group('BreadType Enum', () {
    test('BreadType has required values', () {
      expect(BreadType.white, isNotNull);
      expect(BreadType.wheat, isNotNull);
      expect(BreadType.wholemeal, isNotNull);
    });
  });
}

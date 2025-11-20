import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/cart_item.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/PricingRepository.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late PricingRepository pricingRepo;

    setUp(() {
      pricingRepo = PricingRepository();
      cart = Cart(pricingRepository: pricingRepo);
    });

    test('cart is empty on initialization', () {
      expect(cart.isEmpty(), true);
      expect(cart.isNotEmpty(), false);
      expect(cart.itemCount, 0);
      expect(cart.totalQuantity, 0);
    });

    test('addItem adds a single item to cart', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: 'No onions',
        quantity: 1,
      );

      cart.addItem(item);

      expect(cart.isEmpty(), false);
      expect(cart.isNotEmpty(), true);
      expect(cart.itemCount, 1);
      expect(cart.totalQuantity, 1);
    });

    test('addItem merges identical items', () {
      final item1 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: 'No onions',
        quantity: 2,
      );

      final item2 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: 'No onions',
        quantity: 3,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 1);
      expect(cart.totalQuantity, 5);
    });

    test('addItem keeps different items separate', () {
      final item1 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: 'No onions',
        quantity: 1,
      );

      final item2 = CartItem(
        sandwichType: SandwichType.chickenTeriyaki,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 1,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 2);
      expect(cart.totalQuantity, 2);
    });

    test('removeItem removes item at valid index', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 1,
      );

      cart.addItem(item);
      expect(cart.itemCount, 1);

      cart.removeItem(0);
      expect(cart.itemCount, 0);
      expect(cart.isEmpty(), true);
    });

    test('removeItem does nothing with invalid index', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 1,
      );

      cart.addItem(item);
      cart.removeItem(5);

      expect(cart.itemCount, 1);
    });

    test('updateItemQuantity updates quantity correctly', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      cart.addItem(item);
      cart.updateItemQuantity(0, 5);

      expect(cart.totalQuantity, 5);
    });

    test('updateItemQuantity removes item if quantity is zero', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      cart.addItem(item);
      cart.updateItemQuantity(0, 0);

      expect(cart.itemCount, 0);
    });

    test('updateItemQuantity removes item if quantity is negative', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      cart.addItem(item);
      cart.updateItemQuantity(0, -1);

      expect(cart.itemCount, 0);
    });

    test('clearCart removes all items', () {
      final item1 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      final item2 = CartItem(
        sandwichType: SandwichType.chickenTeriyaki,
        breadType: BreadType.wheat,
        isFootlong: false,
        isToasted: true,
        specialInstructions: 'Extra sauce',
        quantity: 1,
      );

      cart.addItem(item1);
      cart.addItem(item2);
      expect(cart.itemCount, 2);

      cart.clearCart();
      expect(cart.itemCount, 0);
      expect(cart.isEmpty(), true);
    });

    test('subtotal calculates correctly for single item', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      cart.addItem(item);
      // 2 footlong sandwiches at $11.0 each = $22.0
      expect(cart.subtotal, 22.0);
    });

    test('subtotal calculates correctly for multiple items', () {
      final item1 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      final item2 = CartItem(
        sandwichType: SandwichType.chickenTeriyaki,
        breadType: BreadType.wheat,
        isFootlong: false,
        isToasted: true,
        specialInstructions: '',
        quantity: 3,
      );

      cart.addItem(item1);
      cart.addItem(item2);
      // 2 footlong at $11.0 = $22.0
      // 3 six-inch at $7.0 = $21.0
      // Total = $43.0
      expect(cart.subtotal, 43.0);
    });

    test('getItem returns correct item at index', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: 'No onions',
        quantity: 1,
      );

      cart.addItem(item);
      final retrievedItem = cart.getItem(0);

      expect(retrievedItem, isNotNull);
      expect(retrievedItem!.sandwichType, SandwichType.veggieDelight);
      expect(retrievedItem.specialInstructions, 'No onions');
    });

    test('getItem returns null for invalid index', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 1,
      );

      cart.addItem(item);
      expect(cart.getItem(5), isNull);
      expect(cart.getItem(-1), isNull);
    });

    test('items getter returns unmodifiable list', () {
      final item = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 1,
      );

      cart.addItem(item);
      final itemsList = cart.items;

      expect(itemsList.length, 1);
      expect(
        () => itemsList.add(item),
        throwsUnsupportedError,
      );
    });

    test('cart with custom PricingRepository uses provided instance', () {
      final customPricingRepo = PricingRepository();
      final customCart = Cart(pricingRepository: customPricingRepo);

      expect(customCart.subtotal, 0.0);
    });

    test('totalQuantity sums quantities across all items', () {
      final item1 = CartItem(
        sandwichType: SandwichType.veggieDelight,
        breadType: BreadType.white,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 2,
      );

      final item2 = CartItem(
        sandwichType: SandwichType.chickenTeriyaki,
        breadType: BreadType.wheat,
        isFootlong: false,
        isToasted: true,
        specialInstructions: '',
        quantity: 3,
      );

      final item3 = CartItem(
        sandwichType: SandwichType.tunaMelt,
        breadType: BreadType.wholemeal,
        isFootlong: true,
        isToasted: false,
        specialInstructions: '',
        quantity: 5,
      );

      cart.addItem(item1);
      cart.addItem(item2);
      cart.addItem(item3);

      expect(cart.totalQuantity, 10);
    });
  });
}

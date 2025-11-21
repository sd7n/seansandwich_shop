import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/PricingRepository.dart';
import 'cart_item.dart';

class Cart {
  final List<CartItem> _items = [];
  final PricingRepository _pricingRepository;

  Cart({PricingRepository? pricingRepository})
      : _pricingRepository = pricingRepository ?? PricingRepository();

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal {
    double total = 0.0;
    for (var item in _items) {
      final itemPrice = _pricingRepository.calculateTotal(
        quantity: item.quantity,
        isFootlong: item.isFootlong,
      );
      total += itemPrice;
    }
    return total;
  }

  void add(Sandwich sandwich, {required int quantity}) {
    if (quantity <= 0) return;
    
    final cartItem = CartItem(
      sandwichType: sandwich.type,
      breadType: sandwich.breadType,
      isFootlong: sandwich.isFootlong,
      isToasted: false,
      specialInstructions: '',
      quantity: quantity,
    );

    addItem(cartItem);
  }

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere(
      (cartItem) =>
          cartItem.sandwichType == item.sandwichType &&
          cartItem.breadType == item.breadType &&
          cartItem.isFootlong == item.isFootlong &&
          cartItem.isToasted == item.isToasted &&
          cartItem.specialInstructions == item.specialInstructions,
    );

    if (existingIndex >= 0) {
      _items[existingIndex] =
          _items[existingIndex].copyWith(quantity: _items[existingIndex].quantity + item.quantity);
    } else {
      _items.add(item);
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  void updateItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length) {
      if (newQuantity <= 0) {
        removeItem(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: newQuantity);
      }
    }
  }

  void clearCart() {
    _items.clear();
  }

  bool isEmpty() => _items.isEmpty;

  bool isNotEmpty() => _items.isNotEmpty;

  CartItem? getItem(int index) {
    if (index >= 0 && index < _items.length) {
      return _items[index];
    }
    return null;
  }
}

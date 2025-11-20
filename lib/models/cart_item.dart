import 'package:sandwich_shop/main.dart' hide BreadType;
import 'sandwich.dart';

class CartItem {
  final SandwichType sandwichType;
  final BreadType breadType;
  final bool isFootlong;
  final bool isToasted;
  final String specialInstructions;
  final int quantity;

  CartItem({
    required this.sandwichType,
    required this.breadType,
    required this.isFootlong,
    required this.isToasted,
    required this.specialInstructions,
    required this.quantity,
  });

  CartItem copyWith({
    SandwichType? sandwichType,
    BreadType? breadType,
    bool? isFootlong,
    bool? isToasted,
    String? specialInstructions,
    int? quantity,
  }) {
    return CartItem(
      sandwichType: sandwichType ?? this.sandwichType,
      breadType: breadType ?? this.breadType,
      isFootlong: isFootlong ?? this.isFootlong,
      isToasted: isToasted ?? this.isToasted,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          sandwichType == other.sandwichType &&
          breadType == other.breadType &&
          isFootlong == other.isFootlong &&
          isToasted == other.isToasted &&
          specialInstructions == other.specialInstructions &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      sandwichType.hashCode ^
      breadType.hashCode ^
      isFootlong.hashCode ^
      isToasted.hashCode ^
      specialInstructions.hashCode ^
      quantity.hashCode;
}

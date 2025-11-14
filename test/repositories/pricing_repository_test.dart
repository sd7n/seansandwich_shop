import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/PricingRepository.dart';

void main() {
  group('PricingRepository', () {
    final repo = PricingRepository(); // defaults: 7.0 and 11.0

    test('zero quantity yields zero total', () {
      expect(repo.calculateTotal(quantity: 0, isFootlong: false), 0.0);
    });

    test('calculates six-inch total price correctly', () {
      expect(repo.calculateTotal(quantity: 3, isFootlong: false), 21.0);
    });

    test('calculates footlong total price correctly', () {
      expect(repo.calculateTotal(quantity: 2, isFootlong: true), 22.0);
    });
  });
}

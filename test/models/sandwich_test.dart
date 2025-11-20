import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich Model', () {
    test('creates a sandwich with correct properties', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );

      expect(sandwich.type, SandwichType.veggieDelight);
      expect(sandwich.isFootlong, true);
      expect(sandwich.breadType, BreadType.white);
    });

    test('name returns correct value for veggieDelight', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      expect(sandwich.name, 'Veggie Delight');
    });

    test('name returns correct value for chickenTeriyaki', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      expect(sandwich.name, 'Chicken Teriyaki');
    });

    test('name returns correct value for tunaMelt', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );

      expect(sandwich.name, 'Tuna Melt');
    });

    test('name returns correct value for meatballMarinara', () {
      final sandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      expect(sandwich.name, 'Meatball Marinara');
    });

    test('image path for footlong sandwich', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );

      expect(sandwich.image, 'assets/images/veggieDelight_footlong.png');
    });

    test('image path for six-inch sandwich', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      expect(sandwich.image, 'assets/images/chickenTeriyaki_six_inch.png');
    });

    test('image path for all sandwich types - footlong', () {
      final types = [
        SandwichType.veggieDelight,
        SandwichType.chickenTeriyaki,
        SandwichType.tunaMelt,
        SandwichType.meatballMarinara,
      ];

      for (var type in types) {
        final sandwich = Sandwich(
          type: type,
          isFootlong: true,
          breadType: BreadType.white,
        );

        expect(sandwich.image, contains('_footlong.png'));
      }
    });

    test('image path for all sandwich types - six-inch', () {
      final types = [
        SandwichType.veggieDelight,
        SandwichType.chickenTeriyaki,
        SandwichType.tunaMelt,
        SandwichType.meatballMarinara,
      ];

      for (var type in types) {
        final sandwich = Sandwich(
          type: type,
          isFootlong: false,
          breadType: BreadType.wheat,
        );

        expect(sandwich.image, contains('_six_inch.png'));
      }
    });

    test('sandwich with different bread types', () {
      final breads = [BreadType.white, BreadType.wheat, BreadType.wholemeal];

      for (var bread in breads) {
        final sandwich = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: bread,
        );

        expect(sandwich.breadType, bread);
      }
    });
  });
}

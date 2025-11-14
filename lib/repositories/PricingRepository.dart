class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  PricingRepository({this.sixInchPrice = 7.0, this.footlongPrice = 11.0});

  double calculateTotal({required int quantity, required bool isFootlong}) {
    if (quantity <= 0) return 0.0;
    final unit = isFootlong ? footlongPrice : sixInchPrice;
    return unit * quantity;
  }

  String formatCurrency(double value) => '£${value.toStringAsFixed(2)}';
}

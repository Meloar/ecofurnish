import 'package:intl/intl.dart';

var formatter = NumberFormat.decimalPattern();

class Item {
  Item(this.id, this.name, this.description, this.picture, this.price);

  final int id;
  final String name;
  final String description;
  final String picture;
  final int price;

  String getFormattedPrice() {
    final formattedPrice = '${formatter.format(price).replaceAll(',', '.')} Ft';
    return formattedPrice;
  }
}

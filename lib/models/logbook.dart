import 'package:checkcal/models/consumable.dart';

class Logbook {
  final List<Consumable> consumed;
  final DateTime date;
  final String status;

  Logbook({this.consumed, this.date, this.status});
}

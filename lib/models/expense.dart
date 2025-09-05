class Expense {
  final DateTime date;
  final double food;
  final double beverages;
  final double bmtc;
  final double metro;
  final double petrol;
  final double others;

  Expense({
    required this.date,
    required this.food,
    required this.beverages,
    required this.bmtc,
    required this.metro,
    required this.petrol,
    required this.others,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'food': food,
      'beverages': beverages,
      'bmtc': bmtc,
      'metro': metro,
      'petrol': petrol,
      'others': others,
    };
  }

  factory Expense.fromMap(String docId, Map<String, dynamic> map) {
    return Expense(
      date: DateTime.parse(map['date']),
      food: (map['food'] ?? 0).toDouble(),
      beverages: (map['beverages'] ?? 0).toDouble(),
      bmtc: (map['bmtc'] ?? 0).toDouble(),
      metro: (map['metro'] ?? 0).toDouble(),
      petrol: (map['petrol'] ?? 0).toDouble(),
      others: (map['others'] ?? 0).toDouble(),
    );
  }
}

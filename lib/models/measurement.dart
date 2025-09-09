/// Modelo para una medición de lluvia.
class Measurement {
  DateTime date;
  double amount;

  Measurement({required this.date, required this.amount});

  /// Convierte Measurement a Map para almacenamiento.
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }

  /// Crea Measurement desde Map.
  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      date: DateTime.parse(map['date']),
      amount: (map['amount'] as num).toDouble(),
    );
  }
}

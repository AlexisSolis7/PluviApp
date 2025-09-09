import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/measurement.dart';

/// Servicio para manejar la persistencia local de mediciones usando shared_preferences.
class StorageService {
  static const String _key = 'measurements';

  /// Guarda la lista de mediciones localmente.
  static Future<void> saveMeasurements(List<Measurement> measurements) async {
    final prefs = await SharedPreferences.getInstance();
    final list = measurements.map((m) => m.toMap()).toList();
    await prefs.setString(_key, jsonEncode(list));
  }

  /// Obtiene la lista de mediciones almacenadas.
  static Future<List<Measurement>> loadMeasurements() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final List<dynamic> list = jsonDecode(data);
    return list.map((item) => Measurement.fromMap(item)).toList();
  }
}

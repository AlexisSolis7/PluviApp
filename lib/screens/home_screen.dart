import 'package:flutter/material.dart';
import '../models/measurement.dart';
import '../services/storage_service.dart';
import '../widgets/measurement_card.dart';
import '../widgets/motivational_message.dart';
import '../widgets/language_switcher.dart';

/// Pantalla principal con listado de mediciones y botón para agregar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Measurement> _measurements = [];
  bool _loading = true;
  bool _darkMode = false;
  String _language = 'pt';
  final List<Map<String, String>> _messages = [
    {
      'pt': 'A água é vida! Anote suas medições e ajude a ciência.',
      'es': '¡El agua es vida! Registra tus mediciones y ayuda a la ciencia.'
    },
    {
      'pt': 'Dica: sempre meça a chuva no mesmo horário.',
      'es': 'Tip: mide la lluvia siempre a la misma hora.'
    },
    {
      'pt': 'Você sabia? A chuva é essencial para o planeta.',
      'es': '¿Sabías? La lluvia es esencial para el planeta.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
  }

  Future<void> _loadMeasurements() async {
    final list = await StorageService.loadMeasurements();
    setState(() {
      _measurements = list;
      _loading = false;
    });
  }

  void _navigateToAdd() async {
    final result = await Navigator.pushNamed(context, '/add');
    if (result == true) _loadMeasurements();
  }

  void _navigateToEdit(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/edit',
      arguments: {'measurement': _measurements[index], 'index': index},
    );
    if (result == true) _loadMeasurements();
  }

  void _deleteMeasurement(int index) async {
    _measurements.removeAt(index);
    await StorageService.saveMeasurements(_measurements);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_language == 'pt' ? 'Medição removida!' : '¡Medición eliminada!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPt = _language == 'pt';
    return MaterialApp(
      theme: _darkMode
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF2196F3),
                secondary: const Color(0xFF4CAF50),
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF2196F3),
                secondary: const Color(0xFF4CAF50),
              ),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(isPt ? 'PluviApp' : 'PluviApp'),
          backgroundColor: const Color(0xFF2196F3),
          actions: [
            IconButton(
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
              tooltip: isPt ? 'Alternar tema' : 'Alternar tema',
              onPressed: () => setState(() => _darkMode = !_darkMode),
            ),
            LanguageSwitcher(
              currentLanguage: _language,
              onChanged: (lang) => setState(() => _language = lang),
            ),
          ],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  MotivationalMessage(
                    message: (_messages..shuffle()).first[_language]!,
                  ),
                  Expanded(
                    child: _measurements.isEmpty
                        ? Center(
                            child: Text(
                              isPt ? 'Nenhuma medição registrada.' : 'No hay mediciones registradas.',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _measurements.length,
                            itemBuilder: (context, index) {
                              final m = _measurements[index];
                              return MeasurementCard(
                                measurement: m,
                                onEdit: () => _navigateToEdit(index),
                                onDelete: () => _deleteMeasurement(index),
                              );
                            },
                          ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAdd,
          backgroundColor: const Color(0xFF4CAF50),
          child: const Icon(Icons.add),
          tooltip: isPt ? 'Adicionar medição' : 'Agregar medición',
        ),
      ),
    );
  }
}

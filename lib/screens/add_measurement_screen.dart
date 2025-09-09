import 'package:flutter/material.dart';
import '../models/measurement.dart';
import '../services/storage_service.dart';

/// Pantalla para agregar una nueva medición de lluvia.
class AddMeasurementScreen extends StatefulWidget {
  const AddMeasurementScreen({Key? key}) : super(key: key);

  @override
  State<AddMeasurementScreen> createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _amountStr;
  bool _saving = false;

  Future<void> _saveMeasurement() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _saving = true);
    final newMeasurement = Measurement(
      date: _selectedDate!,
      amount: double.parse(_amountStr!),
    );
    final list = await StorageService.loadMeasurements();
    list.add(newMeasurement);
    await StorageService.saveMeasurements(list);
    setState(() => _saving = false);
    Navigator.pop(context, true);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar medición'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _pickDate,
                validator: (_) => _selectedDate == null ? 'Seleccione una fecha' : null,
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cantidad de lluvia (mm)',
                  prefixIcon: Icon(Icons.water_drop),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese la cantidad';
                  final n = double.tryParse(value);
                  if (n == null || n < 0) return 'Ingrese un valor válido';
                  return null;
                },
                onSaved: (value) => _amountStr = value,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saving ? null : _saveMeasurement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Guardar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

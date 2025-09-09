import 'package:flutter/material.dart';
import '../models/measurement.dart';
import '../services/storage_service.dart';

/// Pantalla para editar una medición existente.
class EditMeasurementScreen extends StatefulWidget {
  final Measurement measurement;
  final int index;

  const EditMeasurementScreen({Key? key, required this.measurement, required this.index}) : super(key: key);

  @override
  State<EditMeasurementScreen> createState() => _EditMeasurementScreenState();
}

class _EditMeasurementScreenState extends State<EditMeasurementScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late String _amountStr;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.measurement.date;
    _amountStr = widget.measurement.amount.toString();
  }

  Future<void> _saveMeasurement() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _saving = true);
    final updated = Measurement(
      date: _selectedDate,
      amount: double.parse(_amountStr),
    );
    final list = await StorageService.loadMeasurements();
    list[widget.index] = updated;
    await StorageService.saveMeasurements(list);
    setState(() => _saving = false);
    Navigator.pop(context, true);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
        title: const Text('Editar medición'),
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
                // _selectedDate nunca es null en este contexto
                validator: (_) => null,
                controller: TextEditingController(
                  text: '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _amountStr,
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
                onSaved: (value) => _amountStr = value!,
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
                    : const Text('Guardar cambios', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

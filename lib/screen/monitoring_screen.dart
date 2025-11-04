import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../services/prescription_service.dart';

class GlucoseEntry {
  final DateTime timestamp;
  final double glucose; // mg/dL

  GlucoseEntry({required this.timestamp, required this.glucose});

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'glucose': glucose,
      };

  factory GlucoseEntry.fromJson(Map<String, dynamic> json) => GlucoseEntry(
        timestamp: DateTime.parse(json['timestamp'] as String),
        glucose: (json['glucose'] as num).toDouble(),
      );
}

class MonitoringScreen extends StatefulWidget {
  final Patient patient;

  const MonitoringScreen({super.key, required this.patient});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final List<GlucoseEntry> _entries = [];
  final _glucoseController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addEntry(double glucose) async {
    final entry = GlucoseEntry(timestamp: DateTime.now(), glucose: glucose);
    setState(() => _entries.insert(0, entry));
  }

  @override
  void dispose() {
    _glucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = PrescriptionService();

    return Scaffold(
      appBar: AppBar(title: const Text('Acompanhamento Diário (Simulado)')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _glucoseController,
                    decoration: const InputDecoration(labelText: 'Glicemia (mg/dL)'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final raw = _glucoseController.text.trim().replaceAll(',', '.');
                    final val = double.tryParse(raw);
                    if (val == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valor inválido')));
                      return;
                    }
                    _addEntry(val);
                    _glucoseController.clear();
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _entries.isEmpty
                  ? const Center(child: Text('Nenhuma glicemia registrada.'))
                  : ListView.builder(
                      itemCount: _entries.length,
                      itemBuilder: (context, index) {
                        final e = _entries[index];
                        final suggestion = service.generatePrescription(widget.patient, currentGlucoseMgDl: e.glucose);
                        return Card(
                          child: ListTile(
                            title: Text('${e.glucose.toStringAsFixed(0)} mg/dL'),
                            subtitle: Text('Registrado: ${e.timestamp.toLocal().toString().split('.').first}\n'
                                'Sugestão de correção: ${suggestion.suggestedCorrectionDoseUi != null ? '${suggestion.suggestedCorrectionDoseUi!.toStringAsFixed(1)} UI' : 'Nenhuma'}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: () async {
                // In-memory clear (simulated)
                setState(() => _entries.clear());
              },
              child: const Text('Limpar histórico (simulado)'),
            ),
          ],
        ),
      ),
    );
  }
}

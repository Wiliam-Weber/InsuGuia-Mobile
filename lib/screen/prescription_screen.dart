import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/prescription_service.dart';
import 'monitoring_screen.dart';

class PrescriptionScreen extends StatelessWidget {
  final Patient patient;

  const PrescriptionScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final service = PrescriptionService();
    // In this prototype we don't have a current glucose value; leave null
    final result = service.generatePrescription(patient);

    return Scaffold(
      appBar: AppBar(title: const Text('Prescrição Sugerida')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("📋 Prescrição Gerada", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(result.diet),
            const SizedBox(height: 8),
            Text('Monitorização: ${result.monitoring}'),
            const SizedBox(height: 8),
            Text('Insulina Basal sugerida: ${result.basalInsulinUiPerDay.toStringAsFixed(1)} UI/dia'),
            const SizedBox(height: 8),
            Text(result.rapidRecommendation),
            const SizedBox(height: 8),
            Text('Conduta para Hipoglicemia: ${result.hypoglycemiaInstructions}'),
            if (result.suggestedCorrectionDoseUi != null) ...[
              const SizedBox(height: 8),
              Text('Dose de correção sugerida (se aplicável): ${result.suggestedCorrectionDoseUi!.toStringAsFixed(1)} UI'),
            ],
            const SizedBox(height: 16),
            const Text('\nObservação: Protótipo acadêmico sem validade clínica.', style: TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MonitoringScreen(patient: patient),
                ));
              },
              child: const Text('Acompanhamento diário (simulado)'),
            ),
          ],
        ),
      ),
    );
  }
}

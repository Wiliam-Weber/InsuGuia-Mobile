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
    // Gera a prescrição estruturada
    final result = service.generatePrescription(patient);

    return Scaffold(
      appBar: AppBar(title: const Text('Prescrição Sugerida')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card para os Itens da Prescrição
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "📋 Plano Terapêutico (Sugestão)",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 24),
                      // Criamos a lista de itens dinamicamente
                      ...result.items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ListTile(
                            leading: Icon(
                              item.type == PrescriptionItemType.basal
                                  ? Icons.nightlight_round // Ícone para Basal
                                  : Icons.fast_forward, // Ícone para Correção
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              item.insulinName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                '${item.dose} • ${item.route}\nHorário: ${item.schedule}'),
                            isThreeLine: true,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

              // Card para Orientações
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🔍 Orientações Adicionais",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 24),
                      ListTile(
                        leading: const Icon(Icons.bloodtype, color: Colors.red),
                        title: const Text('Monitorização'),
                        subtitle: Text(result.monitoring),
                      ),
                      ListTile(
                        leading: const Icon(Icons.warning_amber,
                            color: Colors.orange),
                        title: const Text('Conduta para Hipoglicemia'),
                        subtitle: Text(result.hypoglycemiaInstructions),
                      ),
                    ],
                  ),
                ),
              ),

              // Botão para Acompanhamento
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => MonitoringScreen(patient: patient),
                    ));
                  },
                  child: const Text('Acompanhamento diário (simulado)'),
                ),
              ),

              // Disclaimer
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Observação: Protótipo acadêmico sem validade clínica.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
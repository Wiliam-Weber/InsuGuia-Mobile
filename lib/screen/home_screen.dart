import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import 'patient_form_screen.dart';
import 'prescription_screen.dart'; 


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PatientService _patientService = PatientService();
  late Future<List<Patient>> _patientsFuture;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  void _loadPatients() {
    setState(() {
      _patientsFuture = _patientService.getPatients();
    });
  }


  void _navigateToForm() async {

    final bool? pacienteFoiSalvo = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const PatientFormScreen()),
    );


    if (pacienteFoiSalvo == true) {
      _loadPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes Salvos'),
      ),

      body: FutureBuilder<List<Patient>>(
        future: _patientsFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Estado de Erro
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar pacientes: ${snapshot.error}'));
          }


          final patients = snapshot.data;

          if (patients == null || patients.isEmpty) {
            return _buildEmptyState();
          }

          return _buildPatientList(patients);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        tooltip: 'Cadastrar Paciente',
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildPatientList(List<Patient> patients) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(patient.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Idade: ${patient.age}  |  Peso: ${patient.weight.toStringAsFixed(1)} kg'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PrescriptionScreen(patient: patient),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Widget para quando a lista está vazia
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum paciente cadastrado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Clique no botão "+" para adicionar o primeiro paciente.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
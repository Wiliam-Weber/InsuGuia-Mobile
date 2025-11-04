import 'package:flutter/material.dart';
import '../models/patient.dart';
import 'prescription_screen.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _creatinineController = TextEditingController();
  String _selectedGender = 'Masculino';
  String _selectedLocation = 'Enfermaria';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Paciente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o nome';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Idade'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Digite a idade';
                        if (int.tryParse(value) == null) return 'Número inválido';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      items: const [
                        DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                        DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                        DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                      ],
                      onChanged: (v) => setState(() => _selectedGender = v ?? 'Masculino'),
                      decoration: const InputDecoration(labelText: 'Sexo'),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Digite o peso';
                  if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Número inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Altura (cm)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Número inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _creatinineController,
                decoration: const InputDecoration(labelText: 'Creatinina (mg/dL)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Número inválido';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                initialValue: _selectedLocation,
                items: const [
                  DropdownMenuItem(value: 'Enfermaria', child: Text('Enfermaria')),
                  DropdownMenuItem(value: 'UTI', child: Text('UTI')),
                  DropdownMenuItem(value: 'Outros', child: Text('Outros')),
                ],
                onChanged: (v) => setState(() => _selectedLocation = v ?? 'Enfermaria'),
                decoration: const InputDecoration(labelText: 'Local de internação'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Salvar e Gerar Prescrição'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final patient = Patient(
                      name: _nameController.text.trim(),
                      age: int.parse(_ageController.text.trim()),
                      weight: double.parse(_weightController.text.trim().replaceAll(',', '.')),
                      gender: _selectedGender,
                      height: _heightController.text.trim().isEmpty
                          ? null
                          : double.parse(_heightController.text.trim().replaceAll(',', '.')),
                      creatinine: _creatinineController.text.trim().isEmpty
                          ? null
                          : double.parse(_creatinineController.text.trim().replaceAll(',', '.')),
                      admissionLocation: _selectedLocation,
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PrescriptionScreen(patient: patient),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

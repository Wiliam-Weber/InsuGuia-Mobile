import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/patient_service.dart'; 
import '../utils/id_utils.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientService = PatientService(); 
  bool _isSaving = false; 

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _creatinineController = TextEditingController();
  String _selectedGender = 'Masculino';
  String _selectedLocation = 'Enfermaria';

  Widget _spacer() => const SizedBox(height: 16);

  
  Future<void> _onSave() async {

    if (!_formKey.currentState!.validate()) {
      return; 
    }

    setState(() => _isSaving = true);

    try {
      final patient = Patient(
        id: IdUtils.generateId(),
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


      await _patientService.savePatient(patient);


      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente salvo com sucesso!')),
        );

        Navigator.of(context).pop(true);
      }

    } catch (e) {

      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar paciente: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Novo Paciente')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    
                    const Text(
                      'Dados do Paciente',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    _spacer(),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nome *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite o nome';
                        }
                        return null;
                      },
                    ),
                    _spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(labelText: 'Idade *'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Digite a idade';
                              if (int.tryParse(value) == null) return 'Número inválido';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            items: const [
                              DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                              DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                              DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                            ],
                            onChanged: (v) => setState(() => _selectedGender = v ?? 'Masculino'),
                            decoration: const InputDecoration(labelText: 'Sexo *'),
                          ),
                        ),
                      ],
                    ),
                    _spacer(),
                    TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(labelText: 'Peso (kg) *'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Digite o peso';
                        if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Número inválido';
                        return null;
                      },
                    ),
                    _spacer(),
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
                    _spacer(),
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
                    _spacer(),
                    DropdownButtonFormField<String>(
                      value: _selectedLocation,
                      items: const [
                        DropdownMenuItem(value: 'Enfermaria', child: Text('Enfermaria')),
                        DropdownMenuItem(value: 'UTI', child: Text('UTI')),
                        DropdownMenuItem(value: 'Outros', child: Text('Outros')),
                      ],
                      onChanged: (v) => setState(() => _selectedLocation = v ?? 'Enfermaria'),
                      decoration: const InputDecoration(labelText: 'Local de internação'),
                    ),
                    _spacer(),
                    _spacer(),
                    ElevatedButton(
                      onPressed: _isSaving ? null : _onSave,
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Salvar Paciente'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
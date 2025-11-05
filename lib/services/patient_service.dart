import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import '../models/patient.dart';

class PatientService {
  static const String _storageKey = "patient_list";

  Future<List<Patient>> getPatients() async {
    final prefs = await SharedPreferences.getInstance();
    

    final String? patientsString = prefs.getString(_storageKey);

    if (patientsString != null) {

      final List<dynamic> jsonList = jsonDecode(patientsString) as List;
   
      return jsonList
          .map((jsonMap) => Patient.fromJson(jsonMap as Map<String, dynamic>))
          .toList();
    }
    
    return [];
  }

  Future<void> savePatient(Patient patient) async {
    final List<Patient> patients = await getPatients();
    final index = patients.indexWhere((p) => p.id == patient.id);

    if (index != -1) {
      patients[index] = patient;
    } else {
      patients.insert(0, patient);
    }

    final List<Map<String, dynamic>> jsonList =
        patients.map((p) => p.toJson()).toList();

    final String patientsString = jsonEncode(jsonList);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, patientsString);
  }


  Future<void> deletePatient(String patientId) async {
    final List<Patient> patients = await getPatients();

    patients.removeWhere((p) => p.id == patientId);

    // Salva a nova lista (sem o paciente)
    final List<Map<String, dynamic>> jsonList =
        patients.map((p) => p.toJson()).toList();
    final String patientsString = jsonEncode(jsonList);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, patientsString);
  }
}
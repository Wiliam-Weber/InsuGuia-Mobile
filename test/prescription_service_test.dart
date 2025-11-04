import 'package:flutter_test/flutter_test.dart';
import 'package:insuguia_mobile/models/patient.dart';
import 'package:insuguia_mobile/services/prescription_service.dart';

void main() {
  group('PrescriptionService', () {
    final service = PrescriptionService();

    test('calculates basal insulin correctly', () {
      final p = Patient(name: 'Test', age: 50, weight: 70.0, gender: 'Masculino');
      final result = service.generatePrescription(p);
      expect(result.basalInsulinUiPerDay, 70.0 * 0.2);
    });

    test('suggests correction dose when current glucose provided', () {
      final p = Patient(name: 'Test', age: 60, weight: 80.0, gender: 'Feminino');
      final res = service.generatePrescription(p, currentGlucoseMgDl: 200.0);
      // TDD = 0.5 * 80 = 40 -> correctionFactor = 1500 / 40 = 37.5
      // diff = 200 - 140 = 60 -> dose = 60 / 37.5 = 1.6 -> rounded 1.6
      expect(res.suggestedCorrectionDoseUi, isNotNull);
      expect(res.suggestedCorrectionDoseUi!.toStringAsFixed(1), '1.6');
    });
  });
}

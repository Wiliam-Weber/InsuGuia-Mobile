import '../models/patient.dart';

/// NOTE: This is an academic prototype and NOT intended for clinical use.
/// The rules implemented are simple, configurable, and based on common
/// academic examples. Confirm clinical rules with specialists for real use.

class PrescriptionResult {
  final String diet;
  final String monitoring;
  final double basalInsulinUiPerDay;
  final String rapidRecommendation;
  final String hypoglycemiaInstructions;
  final double? suggestedCorrectionDoseUi; // if current glucose provided

  PrescriptionResult({
    required this.diet,
    required this.monitoring,
    required this.basalInsulinUiPerDay,
    required this.rapidRecommendation,
    required this.hypoglycemiaInstructions,
    this.suggestedCorrectionDoseUi,
  });
}

class PrescriptionService {
  /// Generate a prescription suggestion for a NON-CRITICAL inpatient scenario.
  ///
  /// Simple rules (academic prototype):
  /// - Basal insulin: 0.2 UI/kg/day (rounded to 1 decimal)
  /// - Total daily dose (TDD) used for correction: 0.5 UI/kg/day
  /// - Correction factor (Regular insulin): 1500 / TDD
  /// - If [currentGlucoseMgDl] provided, a single correction dose is suggested.
  PrescriptionResult generatePrescription(Patient patient, {double? currentGlucoseMgDl}) {
    final weight = patient.weight;
    final basal = weight * 0.2; // UI/day

    final tdd = weight * 0.5; // UI/day (educational assumption)
    final correctionFactor = tdd > 0 ? 1500.0 / tdd : 0.0;

    double? correctionDose;
    const target = 140.0; // target glucose (mg/dL) for non-critical
    if (currentGlucoseMgDl != null && correctionFactor > 0) {
      final diff = currentGlucoseMgDl - target;
      if (diff > 0) {
        correctionDose = (diff / correctionFactor);
        // Round to 1 decimal and ensure non-negative
        correctionDose = double.parse(correctionDose.toStringAsFixed(1));
        if (correctionDose < 0) correctionDose = 0.0;
      }
    }

    final rapidRec = 'Insulina de ação rápida (Regular) PRN: ajuste conforme glicemia capilar. ' 
        'Correção (se glicemia acima do alvo): use fator de correção aproximado de ${correctionFactor.toStringAsFixed(0)}  (UI por cada ${target.toStringAsFixed(0)} mg/dL acima do alvo).';

  const hypo = 'Hipoglicemia: oferecer 15 g de carboidrato por via oral (se seguro), reavaliar em 15 min; se grave, seguir protocolo institucional.';

    return PrescriptionResult(
      diet: 'Dieta: conforme prescrição nutricional (normal quando indicado).',
      monitoring: 'Monitorização glicêmica capilar: antes das refeições e à noite (mínimo 4x/dia).',
      basalInsulinUiPerDay: double.parse(basal.toStringAsFixed(1)),
      rapidRecommendation: rapidRec,
      hypoglycemiaInstructions: hypo,
      suggestedCorrectionDoseUi: correctionDose,
    );
  }
}


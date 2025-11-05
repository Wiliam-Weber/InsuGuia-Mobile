import '../models/patient.dart';
enum PrescriptionItemType {
  basal,
  correcao,
}


class PrescriptionItem {
  final PrescriptionItemType type;
  final String insulinName; 
  final String dose; 
  final String route; 
  final String schedule; 

  PrescriptionItem({
    required this.type,
    required this.insulinName,
    required this.dose,
    required this.route,
    required this.schedule,
  });
}


class PrescriptionResult {
  final String monitoring;
  final List<PrescriptionItem> items; 
  final String hypoglycemiaInstructions;
  final double? suggestedCorrectionDoseUi; 

  PrescriptionResult({
    required this.monitoring,
    required this.items, 
    required this.hypoglycemiaInstructions,
    this.suggestedCorrectionDoseUi,
  });
}

class PrescriptionService {

  PrescriptionResult generatePrescription(Patient patient, {double? currentGlucoseMgDl}) {
    final weight = patient.weight;
    final basal = weight * 0.2; 
    final tdd = weight * 0.5; 
    final correctionFactor = tdd > 0 ? 1500.0 / tdd : 0.0;

    double? correctionDose;
    const target = 140.0; 
    if (currentGlucoseMgDl != null && correctionFactor > 0) {
      final diff = currentGlucoseMgDl - target;
      if (diff > 0) {
        correctionDose = (diff / correctionFactor);
        correctionDose = double.parse(correctionDose.toStringAsFixed(1));
        if (correctionDose < 0) correctionDose = 0.0;
      }
    }

    List<PrescriptionItem> prescriptionItems = [];

    prescriptionItems.add(
      PrescriptionItem(
        type: PrescriptionItemType.basal,
        insulinName: 'Insulina NPH (Basal)', 
        dose: '${basal.toStringAsFixed(1)} UI',
        route: 'SC', 
        schedule: 'Aplicar às 22:00', 
      ),
    );


    final correctionDoseText = correctionDose != null
        ? '${correctionDose.toStringAsFixed(1)} UI (AGORA)'
        : 'Conforme Glicemia (esquema de correção)';

    final correctionSchedule =
        'Antes do café, almoço e jantar (AC) e se Glicemia > $target mg/dL';

    prescriptionItems.add(
      PrescriptionItem(
        type: PrescriptionItemType.correcao,
        insulinName: 'Insulina Regular (Correção)', 
        dose: correctionDoseText,
        route: 'SC',
        schedule: correctionSchedule,
      ),
    );

    const hypo = 'Hipoglicemia: oferecer 15 g de carboidrato por via oral (se seguro), reavaliar em 15 min; se grave, seguir protocolo institucional.';

    return PrescriptionResult(
      monitoring: 'Monitorização glicêmica capilar: antes das refeições e à noite (mínimo 4x/dia).',
      items: prescriptionItems,
      hypoglycemiaInstructions: hypo,
      suggestedCorrectionDoseUi: correctionDose,
    );
  }
}
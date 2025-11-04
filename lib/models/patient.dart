class Patient {
  final String name;
  final int age;
  final double weight; // kg
  final String gender;
  final double? height; // cm
  final double? creatinine; // mg/dL
  final String? admissionLocation; // e.g., Enfermaria, UTI

  Patient({
    required this.name,
    required this.age,
    required this.weight,
    required this.gender,
    this.height,
    this.creatinine,
    this.admissionLocation,
  });

  double? get bmi {
    if (height == null || height == 0) return null;
    final h = height! / 100.0;
    return weight / (h * h);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'weight': weight,
        'gender': gender,
        'height': height,
        'creatinine': creatinine,
        'admissionLocation': admissionLocation,
      };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json['name'] as String? ?? '',
        age: (json['age'] as num?)?.toInt() ?? 0,
        weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
        gender: json['gender'] as String? ?? '',
        height: (json['height'] as num?)?.toDouble(),
        creatinine: (json['creatinine'] as num?)?.toDouble(),
        admissionLocation: json['admissionLocation'] as String?,
      );
}

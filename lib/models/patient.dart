class Patient {
  final String id;
  final String name;
  final int age;
  final double weight; 
  final String gender;
  final double? height; 
  final double? creatinine; 
  final String? admissionLocation;

  Patient({
    required this.id,
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
        'id': id,
        'name': name,
        'age': age,
        'weight': weight,
        'gender': gender,
        'height': height,
        'creatinine': creatinine,
        'admissionLocation': admissionLocation,
      };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        age: (json['age'] as num?)?.toInt() ?? 0,
        weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
        gender: json['gender'] as String? ?? '',
        height: (json['height'] as num?)?.toDouble(),
        creatinine: (json['creatinine'] as num?)?.toDouble(),
        admissionLocation: json['admissionLocation'] as String?,
      );
}

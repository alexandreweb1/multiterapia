import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { therapist, patient }

enum Specialty { fono, fisio, psico, none }

extension SpecialtyX on Specialty {
  String get label => switch (this) {
        Specialty.fono => 'Fonoaudiologia',
        Specialty.fisio => 'Fisioterapia',
        Specialty.psico => 'Psicologia',
        Specialty.none => '—',
      };

  String get short => switch (this) {
        Specialty.fono => 'Fono',
        Specialty.fisio => 'Fisio',
        Specialty.psico => 'Psico',
        Specialty.none => '—',
      };

  String get code => switch (this) {
        Specialty.fono => 'fono',
        Specialty.fisio => 'fisio',
        Specialty.psico => 'psico',
        Specialty.none => 'none',
      };

  static Specialty parse(String? code) {
    return switch (code) {
      'fono' => Specialty.fono,
      'fisio' => Specialty.fisio,
      'psico' => Specialty.psico,
      _ => Specialty.none,
    };
  }
}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;

  /// Para pacientes: ID do terapeuta vinculado (preenchido no cadastro).
  final String? therapistId;
  final DateTime createdAt;

  /// Especialidade do terapeuta (ou da terapia em curso, no caso do paciente).
  final Specialty specialty;

  /// Registro profissional (CRFa, CREFITO, CRP, etc.) — apenas terapeuta.
  final String? professionalRegistry;

  /// Idade do paciente em anos. Apenas para pacientes; null para terapeuta.
  final int? age;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.therapistId,
    required this.createdAt,
    this.specialty = Specialty.none,
    this.professionalRegistry,
    this.age,
  });

  /// Iniciais (até 2 letras) para usar em avatares.
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  String get firstName => name.trim().split(RegExp(r'\s+')).first;

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: data['role'] == 'therapist' ? UserRole.therapist : UserRole.patient,
      therapistId: data['therapistId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      specialty: SpecialtyX.parse(data['specialty'] as String?),
      professionalRegistry: data['professionalRegistry'] as String?,
      age: (data['age'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': role == UserRole.therapist ? 'therapist' : 'patient',
        'therapistId': therapistId,
        'createdAt': Timestamp.fromDate(createdAt),
        'specialty': specialty.code,
        'professionalRegistry': professionalRegistry,
        'age': age,
      };
}

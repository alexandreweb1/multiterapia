import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

enum SessionStatus { scheduled, live, finished }

extension SessionStatusX on SessionStatus {
  String get code => switch (this) {
        SessionStatus.scheduled => 'scheduled',
        SessionStatus.live => 'live',
        SessionStatus.finished => 'finished',
      };
  static SessionStatus parse(String? c) => switch (c) {
        'live' => SessionStatus.live,
        'finished' => SessionStatus.finished,
        _ => SessionStatus.scheduled,
      };
}

class SessionModel {
  final String id;
  final int number; // Sessão #N
  final String therapistId;
  final String patientId;
  final String patientName;
  final Specialty specialty;
  final DateTime scheduledAt;
  final int durationMinutes;
  final SessionStatus status;
  final String notes;
  final DateTime? notesUpdatedAt;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final bool online;

  const SessionModel({
    required this.id,
    required this.number,
    required this.therapistId,
    required this.patientId,
    required this.patientName,
    required this.specialty,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.status,
    this.notes = '',
    this.notesUpdatedAt,
    this.startedAt,
    this.endedAt,
    this.online = false,
  });

  factory SessionModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return SessionModel(
      id: doc.id,
      number: (d['number'] as num?)?.toInt() ?? 0,
      therapistId: d['therapistId'] as String? ?? '',
      patientId: d['patientId'] as String? ?? '',
      patientName: d['patientName'] as String? ?? '',
      specialty: SpecialtyX.parse(d['specialty'] as String?),
      scheduledAt:
          (d['scheduledAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      durationMinutes: (d['durationMinutes'] as num?)?.toInt() ?? 50,
      status: SessionStatusX.parse(d['status'] as String?),
      notes: d['notes'] as String? ?? '',
      notesUpdatedAt: (d['notesUpdatedAt'] as Timestamp?)?.toDate(),
      startedAt: (d['startedAt'] as Timestamp?)?.toDate(),
      endedAt: (d['endedAt'] as Timestamp?)?.toDate(),
      online: d['online'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'number': number,
        'therapistId': therapistId,
        'patientId': patientId,
        'patientName': patientName,
        'specialty': specialty.code,
        'scheduledAt': Timestamp.fromDate(scheduledAt),
        'durationMinutes': durationMinutes,
        'status': status.code,
        'notes': notes,
        'notesUpdatedAt':
            notesUpdatedAt != null ? Timestamp.fromDate(notesUpdatedAt!) : null,
        'startedAt':
            startedAt != null ? Timestamp.fromDate(startedAt!) : null,
        'endedAt': endedAt != null ? Timestamp.fromDate(endedAt!) : null,
        'online': online,
      };
}

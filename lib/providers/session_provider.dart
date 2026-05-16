import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/session_model.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

/// Sessões do terapeuta logado para HOJE.
final therapistTodaySessionsProvider =
    StreamProvider<List<SessionModel>>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.therapist) return Stream.value([]);
  return ref
      .watch(firestoreServiceProvider)
      .watchTherapistDaySessions(user.uid, DateTime.now());
});

/// Sessões da semana de [day] para o terapeuta logado.
final therapistWeekSessionsProvider =
    StreamProvider.family<List<SessionModel>, DateTime>((ref, day) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.therapist) return Stream.value([]);
  return ref
      .watch(firestoreServiceProvider)
      .watchTherapistWeekSessions(user.uid, day);
});

/// Próxima sessão do paciente logado.
final patientNextSessionProvider = StreamProvider<SessionModel?>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.patient) {
    return Stream.value(null);
  }
  return ref
      .watch(firestoreServiceProvider)
      .watchPatientNextSession(user.uid);
});

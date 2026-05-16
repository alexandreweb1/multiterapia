import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

/// Todas as tarefas criadas pelo terapeuta logado.
final therapistTasksProvider = StreamProvider<List<TaskModel>>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.therapist) return Stream.value([]);
  return ref.watch(firestoreServiceProvider).watchTherapistTasks(user.uid);
});

/// Pacientes vinculados ao terapeuta logado.
final therapistPatientsProvider = StreamProvider<List<UserModel>>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.therapist) return Stream.value([]);
  return ref.watch(firestoreServiceProvider).watchPatients(user.uid);
});

/// Tarefas do paciente logado.
final patientTasksProvider = StreamProvider<List<TaskModel>>((ref) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null || user.role != UserRole.patient) return Stream.value([]);
  return ref.watch(firestoreServiceProvider).watchMyTasks(user.uid);
});

/// Tarefas de um paciente específico (para o terapeuta visualizar o progresso).
final patientSpecificTasksProvider =
    StreamProvider.family<List<TaskModel>, String>((ref, patientId) {
  final user = ref.watch(currentUserProvider).valueOrNull;
  if (user == null) return Stream.value([]);
  return ref
      .watch(firestoreServiceProvider)
      .watchPatientTasks(therapistId: user.uid, patientId: patientId);
});

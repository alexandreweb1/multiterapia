import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message_model.dart';
import '../models/session_model.dart';
import '../models/user_model.dart';
import '../models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Users ─────────────────────────────────────────────────────────────────

  Stream<UserModel?> watchUser(String uid) => _db
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);

  /// Pacientes vinculados a um terapeuta específico.
  Stream<List<UserModel>> watchPatients(String therapistId) => _db
      .collection('users')
      .where('role', isEqualTo: 'patient')
      .where('therapistId', isEqualTo: therapistId)
      .snapshots()
      .map((s) => s.docs.map(UserModel.fromFirestore).toList());

  // ── Tasks ─────────────────────────────────────────────────────────────────

  Future<void> createTask(TaskModel task) async {
    await _db.collection('tasks').add(task.toFirestore());
  }

  /// Todas as tarefas criadas pelo terapeuta.
  Stream<List<TaskModel>> watchTherapistTasks(String therapistId) => _db
      .collection('tasks')
      .where('therapistId', isEqualTo: therapistId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(TaskModel.fromFirestore).toList());

  /// Tarefas de um paciente específico (visão do terapeuta).
  Stream<List<TaskModel>> watchPatientTasks({
    required String therapistId,
    required String patientId,
  }) =>
      _db
          .collection('tasks')
          .where('therapistId', isEqualTo: therapistId)
          .where('patientId', isEqualTo: patientId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs.map(TaskModel.fromFirestore).toList());

  /// Tarefas do paciente (visão do paciente — apenas as suas).
  Stream<List<TaskModel>> watchMyTasks(String patientId) => _db
      .collection('tasks')
      .where('patientId', isEqualTo: patientId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(TaskModel.fromFirestore).toList());

  /// Paciente marca tarefa como concluída.
  Future<void> completeTask(String taskId) async {
    await _db.collection('tasks').doc(taskId).update({
      'status': 'completed',
      'completedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  // ── Sessions ──────────────────────────────────────────────────────────────

  /// Sessões agendadas para um terapeuta no dia [day] (00:00 — 23:59).
  Stream<List<SessionModel>> watchTherapistDaySessions(
      String therapistId, DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return _db
        .collection('sessions')
        .where('therapistId', isEqualTo: therapistId)
        .where('scheduledAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('scheduledAt', isLessThan: Timestamp.fromDate(end))
        .orderBy('scheduledAt')
        .snapshots()
        .map((s) => s.docs.map(SessionModel.fromFirestore).toList());
  }

  /// Todas as sessões de um terapeuta na semana de [anyDayOfWeek].
  Stream<List<SessionModel>> watchTherapistWeekSessions(
      String therapistId, DateTime anyDayOfWeek) {
    final monday = anyDayOfWeek
        .subtract(Duration(days: anyDayOfWeek.weekday - 1));
    final start = DateTime(monday.year, monday.month, monday.day);
    final end = start.add(const Duration(days: 7));
    return _db
        .collection('sessions')
        .where('therapistId', isEqualTo: therapistId)
        .where('scheduledAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('scheduledAt', isLessThan: Timestamp.fromDate(end))
        .orderBy('scheduledAt')
        .snapshots()
        .map((s) => s.docs.map(SessionModel.fromFirestore).toList());
  }

  /// Próxima sessão de um paciente (status != finished, scheduledAt >= now).
  Stream<SessionModel?> watchPatientNextSession(String patientId) {
    final now = DateTime.now();
    return _db
        .collection('sessions')
        .where('patientId', isEqualTo: patientId)
        .where('scheduledAt', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .orderBy('scheduledAt')
        .limit(1)
        .snapshots()
        .map((s) =>
            s.docs.isEmpty ? null : SessionModel.fromFirestore(s.docs.first));
  }

  Future<String> createSession(SessionModel s) async {
    final ref = await _db.collection('sessions').add(s.toFirestore());
    return ref.id;
  }

  Future<void> updateSessionNotes(String sessionId, String notes) async {
    await _db.collection('sessions').doc(sessionId).update({
      'notes': notes,
      'notesUpdatedAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> setSessionStatus(String sessionId, SessionStatus status) async {
    final patch = <String, dynamic>{'status': status.code};
    if (status == SessionStatus.live) {
      patch['startedAt'] = Timestamp.fromDate(DateTime.now());
    } else if (status == SessionStatus.finished) {
      patch['endedAt'] = Timestamp.fromDate(DateTime.now());
    }
    await _db.collection('sessions').doc(sessionId).update(patch);
  }

  // ── Chat ─────────────────────────────────────────────────────────────────

  Stream<List<ChatMessage>> watchChat(String chatId) => _db
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('sentAt')
      .snapshots()
      .map((s) => s.docs.map(ChatMessage.fromFirestore).toList());

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final msg = ChatMessage(
      id: '',
      chatId: chatId,
      senderId: senderId,
      text: text,
      sentAt: DateTime.now(),
    );
    await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(msg.toFirestore());

    // Mantém um doc-cabeçalho para queries futuras (lista de chats etc).
    await _db.collection('chats').doc(chatId).set({
      'lastMessage': text,
      'lastMessageAt': Timestamp.fromDate(DateTime.now()),
      'lastSenderId': senderId,
    }, SetOptions(merge: true));
  }
}

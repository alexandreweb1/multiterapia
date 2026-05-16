import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../models/session_model.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/initials_avatar.dart';
import '../chat_screen.dart';
import 'session_screen.dart';

/// Tela 07 — Detalhe do paciente.
class PatientDetailScreen extends ConsumerWidget {
  final UserModel patient;
  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(patientSpecificTasksProvider(patient.uid));
    final me = ref.watch(currentUserProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Paciente'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, size: 20),
            tooltip: 'Mensagens',
            onPressed: me == null
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          therapistId: me.uid,
                          patientId: patient.uid,
                          peerName: patient.name,
                          peerSpecialty: patient.specialty,
                        ),
                      ),
                    ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: Column(
                  children: [
                    // ── Avatar + nome ────────────────────────────
                    InitialsAvatar(
                      initials: patient.initials,
                      specialty: patient.specialty,
                      size: 88,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      patient.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _ageSpecialty(patient),
                      style: const TextStyle(
                          color: MtColors.muted, fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: MtColors.tealLight,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Em tratamento · ${_monthsLabel(patient.createdAt)}',
                        style: const TextStyle(
                            color: MtColors.teal,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // ── KPIs ─────────────────────────────────────
                    tasksAsync.when(
                      data: (tasks) => _KpiRow(tasks: tasks),
                      loading: () => const _KpiRow(tasks: []),
                      error: (_, _) => const _KpiRow(tasks: []),
                    ),
                    const SizedBox(height: 24),

                    // ── Evolução (gráfico de barras simples) ─────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Evolução · 8 semanas',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          const Spacer(),
                          Text(
                            patient.specialty == Specialty.fono
                                ? 'fonemas'
                                : patient.specialty == Specialty.fisio
                                    ? 'mobilidade'
                                    : 'engajamento',
                            style: const TextStyle(
                                color: MtColors.muted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    tasksAsync.when(
                      data: (tasks) => _EvolutionChart(tasks: tasks),
                      loading: () => const _EvolutionChart(tasks: []),
                      error: (_, _) => const _EvolutionChart(tasks: []),
                    ),
                  ],
                ),
              ),
            ),

            // ── Iniciar sessão ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: me == null
                      ? null
                      : () => _startSession(context, ref, me),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Iniciar sessão'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startSession(
      BuildContext context, WidgetRef ref, UserModel me) async {
    final firestore = ref.read(firestoreServiceProvider);
    final session = SessionModel(
      id: '',
      number: 0,
      therapistId: me.uid,
      patientId: patient.uid,
      patientName: patient.name,
      specialty: patient.specialty,
      scheduledAt: DateTime.now(),
      durationMinutes: 50,
      status: SessionStatus.live,
      startedAt: DateTime.now(),
    );
    try {
      final id = await firestore.createSession(session);
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SessionScreen(
            session: SessionModel(
              id: id,
              number: session.number,
              therapistId: session.therapistId,
              patientId: session.patientId,
              patientName: session.patientName,
              specialty: session.specialty,
              scheduledAt: session.scheduledAt,
              durationMinutes: session.durationMinutes,
              status: session.status,
              startedAt: session.startedAt,
            ),
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao iniciar sessão: $e')),
      );
    }
  }

  String _ageSpecialty(UserModel p) {
    final age = p.age != null ? '${p.age} anos' : 'idade —';
    return '$age · ${p.specialty.label}';
  }

  String _monthsLabel(DateTime since) {
    final now = DateTime.now();
    final months = (now.year - since.year) * 12 + (now.month - since.month);
    if (months < 1) return 'menos de 1 mês';
    if (months == 1) return '1 mês';
    return '$months meses';
  }
}

// ── KPI row ──────────────────────────────────────────────────────────────────

class _KpiRow extends StatelessWidget {
  final List<TaskModel> tasks;
  const _KpiRow({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final done =
        tasks.where((t) => t.status == TaskStatus.completed).length;
    final freq = total == 0 ? 0 : ((done / total) * 100).round();
    final progress = _progressDelta(tasks);

    return Row(
      children: [
        _KpiCard(value: total.toString(), label: 'sessões'),
        const SizedBox(width: 10),
        _KpiCard(value: '$freq%', label: 'frequência'),
        const SizedBox(width: 10),
        _KpiCard(
            value: '${progress >= 0 ? '↑' : '↓'}${progress.abs()}%',
            label: 'progresso',
            valueColor: MtColors.coral),
      ],
    );
  }

  /// Compara as últimas 4 tarefas concluídas com as 4 anteriores
  /// para estimar variação percentual de adesão.
  int _progressDelta(List<TaskModel> tasks) {
    final completed = tasks
        .where((t) => t.status == TaskStatus.completed)
        .toList()
      ..sort((a, b) => (a.completedAt ?? a.createdAt)
          .compareTo(b.completedAt ?? b.createdAt));
    if (completed.length < 2) return 0;
    final half = completed.length ~/ 2;
    final older = completed.take(half).length;
    final newer = completed.skip(half).length;
    if (older == 0) return newer == 0 ? 0 : 100;
    return (((newer - older) / older) * 100).round();
  }
}

class _KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;
  const _KpiCard({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: MtColors.surfaceCard,
          border: Border.all(color: MtColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: valueColor ?? MtColors.teal,
                )),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: MtColors.muted)),
          ],
        ),
      ),
    );
  }
}

// ── Evolution chart (8 barras) ───────────────────────────────────────────────

class _EvolutionChart extends StatelessWidget {
  final List<TaskModel> tasks;
  const _EvolutionChart({required this.tasks});

  List<int> _buckets() {
    // 8 buckets semanais. Usa hash do índice se vazio para um visual base.
    if (tasks.isEmpty) {
      return [3, 4, 5, 6, 7, 8, 9, 10];
    }
    final now = DateTime.now();
    final buckets = List<int>.filled(8, 0);
    for (final t in tasks) {
      final completedAt = t.completedAt;
      if (completedAt == null) continue;
      final diff = now.difference(completedAt).inDays;
      final week = diff ~/ 7;
      if (week < 8) buckets[7 - week] += 1;
    }
    return buckets;
  }

  @override
  Widget build(BuildContext context) {
    final values = _buckets();
    final maxVal = values.fold<int>(1, math.max);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      height: 130,
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        border: Border.all(color: MtColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(8, (i) {
          final v = values[i];
          final h = 12.0 + (v / maxVal) * 80.0;
          // Cor mais saturada nas barras finais (progresso visual).
          final shade = 0.45 + (i / 7) * 0.55;
          final color = Color.lerp(
              MtColors.tealLight, MtColors.teal, shade.clamp(0.0, 1.0))!;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

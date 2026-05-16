import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../models/session_model.dart';
import '../../models/user_model.dart';
import '../../providers/session_provider.dart';
import 'session_screen.dart';

/// Tela 05 — Agenda semanal.
class AgendaScreen extends ConsumerStatefulWidget {
  const AgendaScreen({super.key});

  @override
  ConsumerState<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends ConsumerState<AgendaScreen> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  DateTime get _monday =>
      _selectedDay.subtract(Duration(days: _selectedDay.weekday - 1));

  int _weekOfYear(DateTime d) {
    final firstDayOfYear = DateTime(d.year, 1, 1);
    final dayOfYear = d.difference(firstDayOfYear).inDays;
    return ((dayOfYear - d.weekday + 10) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    final monthYear =
        DateFormat("MMMM · y", 'pt_BR').format(_selectedDay);
    final weekTitle = monthYear
        .split(' · ')
        .asMap()
        .entries
        .map((e) => e.key == 0
            ? e.value[0].toUpperCase() + e.value.substring(1)
            : e.value)
        .join(' · ');

    final week = _weekOfYear(_selectedDay);
    final dayLabel = DateFormat("EEEE · d MMM", 'pt_BR').format(_selectedDay);
    final sessionsAsync =
        ref.watch(therapistWeekSessionsProvider(_selectedDay));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(weekTitle,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            Text('semana $week',
                style:
                    const TextStyle(fontSize: 11, color: MtColors.muted)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, size: 20),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Strip de dias da semana ──────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Row(
              children: List.generate(7, (i) {
                final d = _monday.add(Duration(days: i));
                final selected = d.day == _selectedDay.day &&
                    d.month == _selectedDay.month &&
                    d.year == _selectedDay.year;
                return Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: i == 6 ? 0 : 4),
                    child: _DayChip(
                      date: d,
                      selected: selected,
                      onTap: () => setState(() => _selectedDay = d),
                    ),
                  ),
                );
              }),
            ),
          ),

          // ── Header do dia + contador de sessões ──────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  dayLabel.replaceFirstMapped(
                      RegExp(r'^.'), (m) => m.group(0)!.toUpperCase()),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  _sessionsCountLabel(sessionsAsync),
                  style:
                      const TextStyle(fontSize: 12, color: MtColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Lista de sessões do dia ──────────────────────────────
          Expanded(
            child: sessionsAsync.when(
              data: (all) {
                final today = all
                    .where((s) =>
                        _sameDay(s.scheduledAt, _selectedDay))
                    .toList();
                if (today.isEmpty) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(height: 24),
                      _EmptyDay(),
                      const SizedBox(height: 16),
                      _BlockTimeButton(),
                    ],
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: today.length + 2,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    if (i < today.length) {
                      return _AgendaRow(session: today[i]);
                    }
                    if (i == today.length) {
                      return _FreeSlotHint(sessions: today);
                    }
                    return _BlockTimeButton();
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Erro ao carregar agenda')),
            ),
          ),
        ],
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _sessionsCountLabel(AsyncValue<List<SessionModel>> async) {
    final list = async.valueOrNull ?? const [];
    final today =
        list.where((s) => _sameDay(s.scheduledAt, _selectedDay)).length;
    if (today == 0) return 'sem sessões';
    if (today == 1) return '1 sessão';
    return '$today sessões';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDay = picked);
  }
}

// ── Day chip ─────────────────────────────────────────────────────────────────

class _DayChip extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  const _DayChip({
    required this.date,
    required this.selected,
    required this.onTap,
  });

  static const _names = ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB', 'DOM'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? MtColors.teal : MtColors.surfaceCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? MtColors.teal : MtColors.border,
          ),
        ),
        child: Column(
          children: [
            Text(
              _names[date.weekday - 1],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : MtColors.muted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : MtColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Linha "hora · card" ──────────────────────────────────────────────────────

class _AgendaRow extends StatelessWidget {
  final SessionModel session;
  const _AgendaRow({required this.session});

  Color _bg() => switch (session.specialty) {
        Specialty.fono => MtColors.fonoBg,
        Specialty.fisio => MtColors.fisioBg,
        Specialty.psico => MtColors.psicoBg,
        _ => MtColors.surfaceCard,
      };

  Color _stripe() => switch (session.specialty) {
        Specialty.fono => MtColors.fonoFg,
        Specialty.fisio => MtColors.fisioFg,
        Specialty.psico => MtColors.psicoFg,
        _ => MtColors.muted,
      };

  @override
  Widget build(BuildContext context) {
    final hour = DateFormat('HH:mm').format(session.scheduledAt);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: Text(hour,
              style: const TextStyle(
                  color: MtColors.muted, fontSize: 12)),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SessionScreen(session: session),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: _bg(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: _stripe(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(session.patientName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(
                              '${session.specialty.short} · ${session.durationMinutes} min${session.online ? " · online" : ""}',
                              style: const TextStyle(
                                  color: MtColors.muted, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Empty / hint / block button ──────────────────────────────────────────────

class _EmptyDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border.all(color: MtColors.border, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: const [
          Icon(Icons.event_available_outlined,
              color: MtColors.muted, size: 32),
          SizedBox(height: 8),
          Text(
            'Sem sessões neste dia.',
            style: TextStyle(color: MtColors.muted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _FreeSlotHint extends StatelessWidget {
  final List<SessionModel> sessions;
  const _FreeSlotHint({required this.sessions});

  @override
  Widget build(BuildContext context) {
    if (sessions.length < 2) return const SizedBox.shrink();
    final fmt = DateFormat('HH:mm');
    // Acha o maior gap entre duas sessões consecutivas no dia.
    DateTime? gapStart;
    DateTime? gapEnd;
    Duration biggest = Duration.zero;
    for (var i = 1; i < sessions.length; i++) {
      final prev = sessions[i - 1];
      final next = sessions[i];
      final endPrev =
          prev.scheduledAt.add(Duration(minutes: prev.durationMinutes));
      final gap = next.scheduledAt.difference(endPrev);
      if (gap > biggest) {
        biggest = gap;
        gapStart = endPrev;
        gapEnd = next.scheduledAt;
      }
    }
    if (gapStart == null || biggest.inMinutes < 30) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: MtColors.border)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: MtColors.muted, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Você tem horário livre entre ${fmt.format(gapStart)} e ${fmt.format(gapEnd!)}.',
              style: const TextStyle(
                  color: MtColors.muted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlockTimeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Bloqueio de horário ainda não implementado.')),
        );
      },
      icon: const Icon(Icons.add, size: 18, color: MtColors.teal),
      label: const Text('Bloquear horário',
          style: TextStyle(color: MtColors.teal)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: MtColors.border),
        backgroundColor: MtColors.surfaceCard,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/l10n_helpers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/session_model.dart';
import '../../models/user_model.dart';
import '../../providers/session_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/initials_avatar.dart';
import 'patient_detail_screen.dart';

/// Tela 06 — Lista de pacientes vinculados ao terapeuta logado.
class PatientsListScreen extends ConsumerStatefulWidget {
  const PatientsListScreen({super.key});

  @override
  ConsumerState<PatientsListScreen> createState() =>
      _PatientsListScreenState();
}

class _PatientsListScreenState extends ConsumerState<PatientsListScreen> {
  String _query = '';
  Specialty? _filter;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final patientsAsync = ref.watch(therapistPatientsProvider);
    final weekSessionsAsync =
        ref.watch(therapistWeekSessionsProvider(DateTime.now()));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(t.patientsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.patientsAdvancedFiltersSoon)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Busca ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search,
                    color: MtColors.muted, size: 20),
                hintText: t.patientsSearchHint,
              ),
              onChanged: (v) =>
                  setState(() => _query = v.trim().toLowerCase()),
            ),
          ),

          // ── Chips de filtro ────────────────────────────────────
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _FilterChip(
                  label: t.patientsFilterAll,
                  selected: _filter == null,
                  onTap: () => setState(() => _filter = null),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.specialtyFonoShort,
                  selected: _filter == Specialty.fono,
                  onTap: () => setState(() => _filter = Specialty.fono),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.specialtyFisioShort,
                  selected: _filter == Specialty.fisio,
                  onTap: () => setState(() => _filter = Specialty.fisio),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: t.specialtyPsicoShort,
                  selected: _filter == Specialty.psico,
                  onTap: () => setState(() => _filter = Specialty.psico),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Lista ──────────────────────────────────────────────
          Expanded(
            child: patientsAsync.when(
              data: (patients) {
                final filtered = patients.where((p) {
                  final matchesQuery = _query.isEmpty ||
                      p.name.toLowerCase().contains(_query);
                  final matchesFilter = _filter == null ||
                      p.specialty == _filter;
                  return matchesQuery && matchesFilter;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.people_outline,
                              color: MtColors.muted, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            patients.isEmpty
                                ? t.patientsEmpty
                                : t.patientsEmptyFiltered,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: MtColors.muted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final sessions =
                    weekSessionsAsync.valueOrNull ?? const [];

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final p = filtered[i];
                    final next = _findNextSession(sessions, p.uid);
                    return _PatientCard(
                      patient: p,
                      next: next,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PatientDetailScreen(patient: p),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  Center(child: Text(t.patientsLoadingError)),
            ),
          ),
        ],
      ),
    );
  }

  SessionModel? _findNextSession(
      List<SessionModel> sessions, String patientId) {
    final now = DateTime.now();
    final list = sessions
        .where((s) =>
            s.patientId == patientId && s.scheduledAt.isAfter(now))
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return list.isEmpty ? null : list.first;
  }
}

// ── Filter chip ──────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? MtColors.teal : MtColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(
            color: selected ? MtColors.teal : MtColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : MtColors.ink,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Patient card ─────────────────────────────────────────────────────────────

class _PatientCard extends StatelessWidget {
  final UserModel patient;
  final SessionModel? next;
  final VoidCallback onTap;

  const _PatientCard({
    required this.patient,
    required this.next,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MtColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: MtColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              InitialsAvatar(
                initials: patient.initials,
                specialty: patient.specialty,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _ageSpecialty(context, patient),
                      style: const TextStyle(
                          color: MtColors.muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context).patientsNextShort,
                    style: const TextStyle(
                        color: MtColors.muted, fontSize: 11),
                  ),
                  Text(
                    _nextLabel(context, next),
                    style: const TextStyle(
                      color: MtColors.coral,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _ageSpecialty(BuildContext context, UserModel p) {
    final t = AppLocalizations.of(context);
    final age = p.age != null ? t.patientAgeYears(p.age!) : t.patientAgeUnknown;
    return '$age · ${p.specialty.localizedShort(context)}';
  }

  String _nextLabel(BuildContext context, SessionModel? s) {
    if (s == null) return '—';
    final t = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final sameDay = s.scheduledAt.year == now.year &&
        s.scheduledAt.month == now.month &&
        s.scheduledAt.day == now.day;
    final tomorrow = now.add(const Duration(days: 1));
    final isTomorrow = s.scheduledAt.year == tomorrow.year &&
        s.scheduledAt.month == tomorrow.month &&
        s.scheduledAt.day == tomorrow.day;
    final hh = DateFormat('HH:mm').format(s.scheduledAt);
    if (sameDay) return '${t.patientsToday} $hh';
    if (isTomorrow) return '${t.patientsTomorrow} $hh';
    final dow = DateFormat.E(localeName).format(s.scheduledAt);
    return '$dow $hh';
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/l10n_helpers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/session_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/session_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/initials_avatar.dart';
import '../settings_screen.dart';
import 'agenda_screen.dart';
import 'create_task_screen.dart';
import 'patients_list_screen.dart';
import 'session_screen.dart';

class TherapistDashboard extends ConsumerWidget {
  const TherapistDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    return userAsync.when(
      data: (user) {
        if (user == null) return const SizedBox.shrink();
        return _Body(therapist: user);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => Scaffold(
        body: Center(
          child: Text(AppLocalizations.of(context).errorLoadingProfile),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final UserModel therapist;
  const _Body({required this.therapist});

  String _greeting(AppLocalizations t) {
    final h = DateTime.now().hour;
    if (h < 12) return t.greetingMorning;
    if (h < 18) return t.greetingAfternoon;
    return t.greetingEvening;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toString();
    final today = DateTime.now();
    final fullDate = DateFormat.MMMMEEEEd(localeName).format(today);

    final sessionsAsync = ref.watch(therapistTodaySessionsProvider);
    final patientsAsync = ref.watch(therapistPatientsProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            // ── Header (avatar + greeting + bell) ──────────────────
            _Header(
              therapist: therapist,
              greeting: _greeting(t),
              onAvatarTap: () => _showProfileMenu(context, ref),
            ),
            const SizedBox(height: 22),

            // ── Hoje + data ────────────────────────────────────────
            Text(
              t.today,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.05,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              fullDate.replaceFirstMapped(
                  RegExp(r'^.'), (m) => m.group(0)!.toUpperCase()),
              style: const TextStyle(color: MtColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 18),

            // ── KPIs ───────────────────────────────────────────────
            _StatsRow(
              sessionsAsync: sessionsAsync,
              patientsAsync: patientsAsync,
              onPatientsTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PatientsListScreen(),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // ── Próximas sessões ───────────────────────────────────
            Row(
              children: [
                Text(
                  t.nextSessions,
                  style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AgendaScreen()),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: MtColors.teal,
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  child: Text(t.seeWeek),
                ),
              ],
            ),
            const SizedBox(height: 12),

            sessionsAsync.when(
              data: (sessions) => sessions.isEmpty
                  ? const _EmptySessions()
                  : Column(
                      children: sessions
                          .map((s) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _SessionCard(
                                  session: s,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SessionScreen(session: s),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) =>
                  Center(child: Text(t.errorLoadingSessions)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MtColors.coral,
        foregroundColor: Colors.white,
        elevation: 0,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: MtColors.surfaceCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: MtColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: InitialsAvatar(
                    initials: therapist.initials,
                    specialty: therapist.specialty),
                title: Text(therapist.name,
                    style:
                        const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(therapist.specialty.localizedLabel(context)),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.copy, color: MtColors.teal),
                title: Text(t.copyLinkId),
                subtitle: Text(t.copyLinkIdSubtitle),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: therapist.uid));
                  Navigator.pop(sheetCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.idCopied)),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.settings_outlined, color: MtColors.teal),
                title: Text(t.profileSettings),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: MtColors.coral),
                title: Text(t.signOut),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  ref.read(authServiceProvider).signOut();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final UserModel therapist;
  final String greeting;
  final VoidCallback onAvatarTap;

  const _Header({
    required this.therapist,
    required this.greeting,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: InitialsAvatar(
            initials: therapist.initials,
            size: 44,
            specialty: therapist.specialty,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting,
                  style:
                      const TextStyle(color: MtColors.muted, fontSize: 13)),
              Text(
                therapist.firstName,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        _BellButton(onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).noNotifications),
            ),
          );
        }),
      ],
    );
  }
}

class _BellButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BellButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: MtColors.border),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const _BellWithDot(),
      ),
    );
  }
}

class _BellWithDot extends StatelessWidget {
  const _BellWithDot();
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.notifications_none_rounded,
            color: MtColors.ink, size: 22),
        Positioned(
          top: -1,
          right: -1,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: MtColors.coral,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

// ── KPIs ─────────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final AsyncValue<List<SessionModel>> sessionsAsync;
  final AsyncValue<List<UserModel>> patientsAsync;
  final VoidCallback onPatientsTap;

  const _StatsRow({
    required this.sessionsAsync,
    required this.patientsAsync,
    required this.onPatientsTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final sessions = sessionsAsync.valueOrNull ?? const [];
    final patients = patientsAsync.valueOrNull ?? const [];
    final totalMin = sessions.fold<int>(0, (a, s) => a + s.durationMinutes);
    final hours = (totalMin / 60).floor();
    final mins = totalMin % 60;
    final hoursLabel = totalMin == 0
        ? '0h'
        : (mins == 0
            ? '${hours}h'
            : '${hours}h${mins.toString().padLeft(2, '0')}');

    return Row(
      children: [
        _StatCard(
          value: sessions.length.toString(),
          label: t.statSessions,
        ),
        const SizedBox(width: 10),
        _StatCard(
          value: patients.length.toString(),
          label: t.statPatients,
          onTap: onPatientsTap,
        ),
        const SizedBox(width: 10),
        _StatCard(
          value: hoursLabel,
          label: t.statScheduled,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;
  const _StatCard({required this.value, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: MtColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: MtColors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: MtColors.teal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 12, color: MtColors.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Session card ─────────────────────────────────────────────────────────────

class _SessionCard extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onTap;

  const _SessionCard({required this.session, required this.onTap});

  Color _stripeColor() => switch (session.specialty) {
        Specialty.fono => MtColors.coral,
        Specialty.fisio => MtColors.teal,
        Specialty.psico => MtColors.psicoFg,
        Specialty.none => MtColors.muted,
      };

  ({String label, Color bg, Color fg}) _statusChip(AppLocalizations t) {
    final now = DateTime.now();
    if (session.status == SessionStatus.live) {
      return (
        label: t.sessionStatusInProgress,
        bg: MtColors.coralLight,
        fg: MtColors.coral
      );
    }
    final diff = session.scheduledAt.difference(now);
    if (diff.isNegative) {
      return (
        label: t.sessionStatusLate,
        bg: MtColors.coralLight,
        fg: MtColors.coral,
      );
    }
    if (diff.inHours < 1 && diff.inMinutes < 30) {
      return (
        label: t.sessionStatusConfirmed,
        bg: MtColors.tealLight,
        fg: MtColors.teal,
      );
    }
    return (
      label: diff.inHours >= 1
          ? t.sessionInHours(diff.inHours)
          : t.sessionInMinutes(diff.inMinutes),
      bg: MtColors.surface,
      fg: MtColors.muted,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final timeFmt = DateFormat('HH:mm');
    final chip = _statusChip(t);
    return Material(
      color: MtColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: MtColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _stripeColor(),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${timeFmt.format(session.scheduledAt)} · ${session.patientName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MtColors.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${session.specialty.localizedShort(context)} · ${session.durationMinutes} min',
                        style: const TextStyle(
                            color: MtColors.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: chip.bg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    chip.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: chip.fg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySessions extends StatelessWidget {
  const _EmptySessions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        border: Border.all(color: MtColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Icon(Icons.event_available_outlined,
              color: MtColors.muted, size: 36),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).noSessionsToday,
            style: const TextStyle(color: MtColors.muted, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/l10n_helpers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/session_model.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/session_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/initials_avatar.dart';
import '../settings_screen.dart';

class PatientDashboard extends ConsumerStatefulWidget {
  const PatientDashboard({super.key});

  @override
  ConsumerState<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends ConsumerState<PatientDashboard> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) return const SizedBox.shrink();
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: _tab,
              children: [
                _HomeTab(patient: user),
                _CalendarTab(patient: user),
                _ActivityTab(patient: user),
                _ProfileTab(patient: user),
              ],
            ),
          ),
          bottomNavigationBar: _BottomNav(
            current: _tab,
            onTap: (i) => setState(() => _tab = i),
          ),
        );
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

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MtColors.surfaceCard,
        border: Border(top: BorderSide(color: MtColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _NavItem(
                  icon: Icons.home_rounded,
                  selected: current == 0,
                  onTap: () => onTap(0)),
              _NavItem(
                  icon: Icons.calendar_today_outlined,
                  selected: current == 1,
                  onTap: () => onTap(1)),
              _NavItem(
                  icon: Icons.show_chart_rounded,
                  selected: current == 2,
                  onTap: () => onTap(2)),
              _NavItem(
                  icon: Icons.person_outline,
                  selected: current == 3,
                  onTap: () => onTap(3)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color: selected ? MtColors.teal : MtColors.muted,
          ),
        ),
      ),
    );
  }
}

// ── Home tab ──────────────────────────────────────────────────────────────────

class _HomeTab extends ConsumerWidget {
  final UserModel patient;
  const _HomeTab({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tasksAsync = ref.watch(patientTasksProvider);
    final nextSessionAsync = ref.watch(patientNextSessionProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        // ── Header ─────────────────────────────────────────────
        Row(
          children: [
            InitialsAvatar(
              initials: patient.initials,
              specialty: patient.specialty,
              size: 44,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.patientHi,
                      style: const TextStyle(
                          color: MtColors.muted, fontSize: 13)),
                  Text(
                    patient.firstName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: MtColors.surfaceCard,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: MtColors.border),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none_rounded,
                    color: MtColors.ink, size: 20),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // ── Próxima sessão (hero teal) ─────────────────────────
        nextSessionAsync.when(
          data: (s) => s == null
              ? _NoSessionCard(therapistId: patient.therapistId)
              : _NextSessionCard(session: s),
          loading: () =>
              _NextSessionPlaceholder(text: t.commonLoading),
          error: (_, _) =>
              _NextSessionPlaceholder(text: t.patientLoadingError),
        ),
        const SizedBox(height: 22),

        // ── Atividades para hoje ───────────────────────────────
        tasksAsync.when(
          data: (tasks) => _ActivitiesSection(
            tasks: tasks,
            onComplete: (task) async {
              try {
                await ref
                    .read(firestoreServiceProvider)
                    .completeTask(task.id);
              } catch (_) {}
            },
          ),
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (_, _) =>
              Center(child: Text(t.patientActivitiesLoadingError)),
        ),
      ],
    );
  }
}

// ── Outros tabs (placeholders sólidos) ────────────────────────────────────────

class _CalendarTab extends StatelessWidget {
  final UserModel patient;
  const _CalendarTab({required this.patient});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final therapistRef = patient.therapistId == null
        ? t.placeholderYourTherapist
        : t.placeholderDr;
    return _PlaceholderTab(
      icon: Icons.calendar_today_outlined,
      title: t.tabCalendarTitle,
      message: t.tabCalendarMsg(therapistRef),
    );
  }
}

class _ActivityTab extends ConsumerWidget {
  final UserModel patient;
  const _ActivityTab({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tasksAsync = ref.watch(patientTasksProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.evolutionTitle,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            t.evolutionSubtitle,
            style: const TextStyle(color: MtColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                final done = tasks
                    .where((t) => t.status == TaskStatus.completed)
                    .length;
                final total = tasks.length;
                final pct = total == 0 ? 0 : (done / total * 100).round();
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: MtColors.surfaceCard,
                        border: Border.all(color: MtColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text('$pct%',
                              style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: MtColors.teal)),
                          const SizedBox(height: 4),
                          Text(t.evolutionAdherence,
                              style: const TextStyle(
                                  color: MtColors.muted,
                                  fontSize: 13)),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: total == 0 ? 0 : done / total,
                              minHeight: 8,
                              color: MtColors.teal,
                              backgroundColor: MtColors.tealLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _MiniStat(
                              value: '$done',
                              label: t.evolutionCompleted),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MiniStat(
                              value: '${total - done}',
                              label: t.evolutionPending),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  Center(child: Text(t.patientLoadingError)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends ConsumerWidget {
  final UserModel patient;
  const _ProfileTab({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        Center(
          child: InitialsAvatar(
            initials: patient.initials,
            specialty: patient.specialty,
            size: 88,
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Text(patient.name,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(patient.email,
              style: const TextStyle(
                  color: MtColors.muted, fontSize: 13)),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: MtColors.surfaceCard,
            border: Border.all(color: MtColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.settings_outlined,
                    color: MtColors.muted),
                title: Text(t.profileSettings),
                trailing: const Icon(Icons.chevron_right,
                    color: MtColors.muted),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                ),
              ),
              const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: MtColors.border),
              ListTile(
                leading: const Icon(Icons.lock_outline,
                    color: MtColors.muted),
                title: Text(t.profilePrivacy),
                trailing: const Icon(Icons.chevron_right,
                    color: MtColors.muted),
                onTap: () {},
              ),
              const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: MtColors.border),
              ListTile(
                leading: const Icon(Icons.help_outline,
                    color: MtColors.muted),
                title: Text(t.profileHelp),
                trailing: const Icon(Icons.chevron_right,
                    color: MtColors.muted),
                onTap: () {},
              ),
              const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: MtColors.border),
              ListTile(
                leading: const Icon(Icons.logout, color: MtColors.coral),
                title: Text(t.signOut,
                    style: const TextStyle(color: MtColors.coral)),
                onTap: () => ref.read(authServiceProvider).signOut(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Helpers do Home ──────────────────────────────────────────────────────────

class _NextSessionCard extends ConsumerWidget {
  final SessionModel session;
  const _NextSessionCard({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toString();
    final isToday = _isToday(session.scheduledAt);
    final hour = DateFormat('HH:mm').format(session.scheduledAt);
    final headline = isToday
        ? t.patientTodayAt(hour)
        : '${DateFormat.MMMEd(localeName).format(session.scheduledAt)}, $hour';

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MtColors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.patientNextSessionKicker,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                headline,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t.patientWithTherapist(
                  t.patientYourTherapist,
                  session.specialty.localizedLabel(context),
                ),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MtColors.tealDark,
                  minimumSize: const Size(0, 44),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.videoRoomSoon)),
                  );
                },
                icon: const Icon(Icons.videocam_outlined,
                    color: Colors.white, size: 18),
                label: Text(t.patientJoinRoom),
              ),
            ],
          ),
        ),
        Positioned(
          right: -10,
          bottom: -10,
          child: Opacity(
            opacity: 0.18,
            child: SvgPicture.asset(
              'assets/logo/multiterapia_mark_only.svg',
              width: 110,
              colorFilter: const ColorFilter.mode(
                  Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  bool _isToday(DateTime t) {
    final now = DateTime.now();
    return t.year == now.year && t.month == now.month && t.day == now.day;
  }
}

class _NextSessionPlaceholder extends StatelessWidget {
  final String text;
  const _NextSessionPlaceholder({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MtColors.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style:
              const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

class _NoSessionCard extends ConsumerWidget {
  final String? therapistId;
  const _NoSessionCard({required this.therapistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MtColors.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.patientNoSessionKicker,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            t.patientAllQuiet,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            therapistId == null
                ? t.patientLinkTherapist
                : t.patientTherapistWillSchedule,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ActivitiesSection extends StatelessWidget {
  final List<TaskModel> tasks;
  final ValueChanged<TaskModel> onComplete;
  const _ActivitiesSection(
      {required this.tasks, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final today = tasks.where(_isForToday).toList();
    final completed =
        today.where((t) => t.status == TaskStatus.completed).length;

    if (today.isEmpty && tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: MtColors.surfaceCard,
          border: Border.all(color: MtColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            const Icon(Icons.assignment_outlined,
                color: MtColors.muted, size: 36),
            const SizedBox(height: 8),
            Text(l.patientNoActivities,
                style: const TextStyle(
                    color: MtColors.muted, fontSize: 13)),
          ],
        ),
      );
    }

    final list = today.isEmpty ? tasks : today;
    final doneShown =
        list.where((t) => t.status == TaskStatus.completed).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(l.patientActivitiesForToday,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15)),
            const Spacer(),
            Text(
              today.isEmpty
                  ? '$doneShown / ${list.length}'
                  : '$completed / ${today.length}',
              style: const TextStyle(
                  color: MtColors.teal,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...list.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ActivityTile(task: task, onComplete: () => onComplete(task)),
            )),
      ],
    );
  }

  bool _isForToday(TaskModel t) {
    final now = DateTime.now();
    return t.scheduledAt.year == now.year &&
        t.scheduledAt.month == now.month &&
        t.scheduledAt.day == now.day;
  }
}

class _ActivityTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onComplete;

  const _ActivityTile({required this.task, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final done = task.status == TaskStatus.completed;
    return Material(
      color: MtColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: MtColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          if (task.link != null && task.link!.isNotEmpty) {
            final uri = Uri.tryParse(task.link!);
            if (uri != null) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: done ? null : onComplete,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        done ? MtColors.teal : MtColors.surfaceCard,
                    border: Border.all(
                        color: done ? MtColors.teal : MtColors.border,
                        width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: done
                      ? const Icon(Icons.check,
                          color: Colors.white, size: 16)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: done ? MtColors.muted : MtColors.ink,
                        decoration: done
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _subtitle(context, task),
                      style: const TextStyle(
                          color: MtColors.muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (!done)
                const Icon(Icons.chevron_right,
                    color: MtColors.muted, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(BuildContext context, TaskModel task) {
    final l = AppLocalizations.of(context);
    final status = task.status == TaskStatus.completed
        ? l.taskCompleted
        : l.taskPending;
    final body = task.description.isEmpty
        ? l.taskDefaultActivity
        : task.description.split('.').first;
    return '$body · $status';
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  const _MiniStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        border: Border.all(color: MtColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: MtColors.teal)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: MtColors.muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _PlaceholderTab({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: MtColors.muted),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: MtColors.muted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

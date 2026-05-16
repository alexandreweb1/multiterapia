import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/l10n_helpers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/session_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/initials_avatar.dart';

/// Tela 09 — Sessão / Notas. Notas + exercícios atribuídos + status ao vivo.
class SessionScreen extends ConsumerStatefulWidget {
  final SessionModel session;
  const SessionScreen({super.key, required this.session});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late final TextEditingController _notesCtrl;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  late SessionStatus _status;

  @override
  void initState() {
    super.initState();
    _notesCtrl = TextEditingController(text: widget.session.notes);
    _status = widget.session.status;
    if (_status == SessionStatus.live) _startTicker();
  }

  void _startTicker() {
    final start = widget.session.startedAt ?? DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsed = DateTime.now().difference(start));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _notesCtrl.dispose();
    super.dispose();
  }

  String _formatElapsed(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final h = d.inHours;
    if (h > 0) return '${h.toString().padLeft(2, '0')}:$m:$s';
    return '$m:$s';
  }

  Future<void> _start() async {
    setState(() {
      _status = SessionStatus.live;
      _elapsed = Duration.zero;
    });
    _startTicker();
    try {
      await ref
          .read(firestoreServiceProvider)
          .setSessionStatus(widget.session.id, SessionStatus.live);
    } catch (_) {/* ignore offline */}
  }

  Future<void> _finish() async {
    _timer?.cancel();
    setState(() => _status = SessionStatus.finished);
    try {
      await ref.read(firestoreServiceProvider).updateSessionNotes(
          widget.session.id, _notesCtrl.text.trim());
      await ref
          .read(firestoreServiceProvider)
          .setSessionStatus(widget.session.id, SessionStatus.finished);
    } catch (_) {}
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).sessionFinished),
        ),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _saveNotes() async {
    try {
      await ref.read(firestoreServiceProvider).updateSessionNotes(
          widget.session.id, _notesCtrl.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).sessionNotesSaved),
          ),
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final s = widget.session;
    final isLive = _status == SessionStatus.live;
    final timeLabel = isLive
        ? _formatElapsed(_elapsed)
        : DateFormat('HH:mm').format(s.scheduledAt);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(t.sessionTitleNumbered(s.number > 0 ? s.number.toString() : '').trim(),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            Text(
              isLive
                  ? t.sessionStatusOngoing(timeLabel)
                  : t.sessionStatusScheduled(timeLabel),
              style:
                  const TextStyle(fontSize: 11, color: MtColors.muted),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            onPressed: _saveNotes,
            tooltip: t.sessionSaveNotesTooltip,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header paciente + status ─────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  InitialsAvatar(
                    initials: _initialsFromName(s.patientName),
                    specialty: s.specialty,
                    size: 44,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.patientName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(s.specialty.localizedLabel(context),
                            style: const TextStyle(
                                color: MtColors.muted, fontSize: 12)),
                      ],
                    ),
                  ),
                  if (isLive) const _LivePill(),
                ],
              ),
            ),

            // ── Notas ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.sessionNotesTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MtColors.surfaceCard,
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: MtColors.border),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _notesCtrl,
                            maxLines: 6,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: t.sessionNotesHint,
                              contentPadding: EdgeInsets.zero,
                              filled: false,
                            ),
                          ),
                          if (s.notesUpdatedAt != null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.history,
                                        size: 12,
                                        color: MtColors.muted),
                                    const SizedBox(width: 4),
                                    Text(
                                      t.sessionNotesEdited(
                                          _relative(t, s.notesUpdatedAt!)),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: MtColors.muted),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      t.sessionExercisesTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    _ExerciseTile(
                      icon: Icons.air,
                      iconBg: MtColors.fisioBg,
                      iconColor: MtColors.fisioFg,
                      title: t.sessionExerciseBreathing,
                      subtitle: t.sessionExerciseBreathingSubtitle,
                    ),
                    const SizedBox(height: 10),
                    _ExerciseTile(
                      icon: Icons.menu_book_outlined,
                      iconBg: MtColors.coralLight,
                      iconColor: MtColors.coral,
                      title: t.sessionExerciseReading,
                      subtitle: t.sessionExerciseReadingSubtitle,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Botão (Iniciar / Finalizar) ─────────────────────
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isLive ? MtColors.coral : MtColors.teal,
                  ),
                  onPressed: isLive ? _finish : _start,
                  icon: Icon(
                    isLive ? Icons.check : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: Text(isLive ? t.sessionFinish : t.sessionStart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  String _relative(AppLocalizations t, DateTime when) {
    final diff = DateTime.now().difference(when);
    if (diff.inMinutes < 1) return t.relativeJustNow;
    if (diff.inMinutes < 60) return t.relativeMinutes(diff.inMinutes);
    if (diff.inHours < 24) return t.relativeHours(diff.inHours);
    return DateFormat('dd/MM HH:mm').format(when);
  }
}

class _LivePill extends StatelessWidget {
  const _LivePill();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: MtColors.coralLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _PulseDot(),
          const SizedBox(width: 6),
          Text(AppLocalizations.of(context).sessionLivePill,
              style: const TextStyle(
                  color: MtColors.coral,
                  fontWeight: FontWeight.w600,
                  fontSize: 11)),
        ],
      ),
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: MtColors.coral,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _ExerciseTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MtColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: MtColors.muted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

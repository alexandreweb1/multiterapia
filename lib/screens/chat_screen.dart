import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/chat_message_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/initials_avatar.dart';

/// Tela 10 — Chat 1:1 entre terapeuta e paciente.
class ChatScreen extends ConsumerStatefulWidget {
  final String therapistId;
  final String patientId;
  final String peerName;
  final Specialty peerSpecialty;
  final String? peerSubtitle; // ex: "mãe do Carlos · online"

  const ChatScreen({
    super.key,
    required this.therapistId,
    required this.patientId,
    required this.peerName,
    this.peerSpecialty = Specialty.none,
    this.peerSubtitle,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  String get _chatId =>
      ChatMessage.chatIdOf(widget.therapistId, widget.patientId);

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    final me = ref.read(currentUserProvider).valueOrNull;
    if (me == null) return;
    _ctrl.clear();
    try {
      await ref.read(firestoreServiceProvider).sendMessage(
            chatId: _chatId,
            senderId: me.uid,
            text: text,
          );
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).chatSendFailed(e.toString()),
            ),
          ),
        );
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final me = ref.watch(currentUserProvider).valueOrNull;
    final messagesAsync = ref.watch(chatMessagesProvider(_chatId));
    final initials = _initials(widget.peerName);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                InitialsAvatar(
                  initials: initials,
                  specialty: widget.peerSpecialty,
                  size: 36,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: MtColors.teal,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: MtColors.surface, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.peerName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(
                    widget.peerSubtitle ?? t.chatOnline,
                    style: const TextStyle(
                        color: MtColors.muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined,
                color: MtColors.teal, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined,
                color: MtColors.teal, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messagesAsync.when(
                data: (messages) {
                  if (messages.isEmpty) {
                    return Center(
                      child: Text(
                        t.chatNoMessages,
                        style: const TextStyle(
                            color: MtColors.muted, fontSize: 13),
                      ),
                    );
                  }
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom());
                  return ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    itemCount: messages.length + 1,
                    itemBuilder: (_, i) {
                      if (i == 0) return _DateSeparator(date: messages.first.sentAt);
                      final m = messages[i - 1];
                      final isMe = me != null && m.senderId == me.uid;
                      return _Bubble(
                        message: m,
                        isMe: isMe,
                        peerInitials: initials,
                        peerSpecialty: widget.peerSpecialty,
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) => Center(
                  child: Text(t.chatLoadingError),
                ),
              ),
            ),
            _InputBar(
              controller: _ctrl,
              onSend: _send,
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first[0];
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }
}

// ── Bubble ───────────────────────────────────────────────────────────────────

class _Bubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  final String peerInitials;
  final Specialty peerSpecialty;

  const _Bubble({
    required this.message,
    required this.isMe,
    required this.peerInitials,
    required this.peerSpecialty,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? MtColors.teal : MtColors.surfaceCard;
    final fg = isMe ? Colors.white : MtColors.ink;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : 4),
      bottomRight: Radius.circular(isMe ? 4 : 16),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            InitialsAvatar(
              initials: peerInitials,
              specialty: peerSpecialty,
              size: 28,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: radius,
                border: isMe
                    ? null
                    : Border.all(color: MtColors.border),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: fg, fontSize: 14, height: 1.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateSeparator extends StatelessWidget {
  final DateTime date;
  const _DateSeparator({required this.date});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    final hour = DateFormat('HH:mm').format(date);
    final label = isToday
        ? t.chatTodaySeparator(hour)
        : t.chatDateSeparator(DateFormat('dd/MM').format(date));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: MtColors.muted, fontSize: 11),
        ),
      ),
    );
  }
}

// ── Input bar ────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file,
                color: MtColors.muted, size: 22),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: MtColors.surfaceCard,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: MtColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: AppLocalizations.of(context).chatInputHint,
                        filled: false,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                  const Icon(Icons.emoji_emotions_outlined,
                      color: MtColors.muted, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: MtColors.teal,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onSend,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.send_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

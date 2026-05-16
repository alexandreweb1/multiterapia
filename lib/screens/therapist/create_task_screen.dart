import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/task_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  /// Quando aberto a partir do card de um paciente, pré-seleciona o paciente.
  final UserModel? preSelectedPatient;

  const CreateTaskScreen({super.key, this.preSelectedPatient});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _instrCtrl = TextEditingController();
  final _linkCtrl = TextEditingController();

  UserModel? _selectedPatient;
  DateTime _scheduledAt = DateTime.now().add(const Duration(days: 1));
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedPatient = widget.preSelectedPatient;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _instrCtrl.dispose();
    _linkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt),
    );
    if (time == null || !mounted) return;

    setState(() {
      _scheduledAt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final t = AppLocalizations.of(context);
    if (_selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.taskSelectPatient)),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final therapist = ref.read(currentUserProvider).valueOrNull;
      if (therapist == null) return;

      final task = TaskModel(
        id: '',
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        instructions: _instrCtrl.text.trim(),
        link: _linkCtrl.text.trim().isEmpty ? null : _linkCtrl.text.trim(),
        therapistId: therapist.uid,
        patientId: _selectedPatient!.uid,
        patientName: _selectedPatient!.name,
        status: TaskStatus.pending,
        scheduledAt: _scheduledAt,
        createdAt: DateTime.now(),
      );

      await ref.read(firestoreServiceProvider).createTask(task);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.taskSendSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.taskSendError(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toString();
    final patientsAsync = ref.watch(therapistPatientsProvider);
    final fmt = DateFormat.yMd(localeName).add_Hm();

    return Scaffold(
      appBar: AppBar(title: Text(t.taskNew)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Seletor de Paciente ──────────────────────────────────
              patientsAsync.when(
                data: (patients) => patients.isEmpty
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            t.taskNoPatients,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      )
                    : DropdownButtonFormField<UserModel>(
                        initialValue: _selectedPatient,
                        decoration: InputDecoration(
                          labelText: t.taskPatient,
                          prefixIcon: const Icon(Icons.person_outlined),
                        ),
                        items: patients
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p.name),
                                ))
                            .toList(),
                        onChanged: (p) =>
                            setState(() => _selectedPatient = p),
                        validator: (_) =>
                            _selectedPatient == null ? t.taskSelectPatient : null,
                      ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) => Text(t.taskLoadingError),
              ),
              const SizedBox(height: 16),

              // ── Título ───────────────────────────────────────────────
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: t.taskTitleLabel,
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (v) => v!.isEmpty ? t.taskTitleRequired : null,
              ),
              const SizedBox(height: 16),

              // ── Descrição ────────────────────────────────────────────
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: t.taskDescription,
                  prefixIcon: const Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (v) =>
                    v!.isEmpty ? t.taskDescriptionRequired : null,
              ),
              const SizedBox(height: 16),

              // ── Data / Hora ──────────────────────────────────────────
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(t.taskDatetime),
                subtitle: Text(fmt.format(_scheduledAt)),
                trailing: const Icon(Icons.edit_calendar_outlined),
                onTap: _pickDateTime,
              ),
              const Divider(),
              const SizedBox(height: 8),

              // ── Instruções ───────────────────────────────────────────
              TextFormField(
                controller: _instrCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: t.taskInstructions,
                  prefixIcon: const Icon(Icons.list_alt_outlined),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),

              // ── Link ─────────────────────────────────────────────────
              TextFormField(
                controller: _linkCtrl,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: t.taskLink,
                  prefixIcon: const Icon(Icons.link),
                  hintText: 'https://...',
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _submit,
                icon: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(t.taskSend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

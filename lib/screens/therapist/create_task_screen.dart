import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
    if (_selectedPatient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um paciente')),
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
          const SnackBar(
            content: Text('Terapia enviada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(therapistPatientsProvider);
    final fmt = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Terapia')),
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
                            'Nenhum paciente disponível.\nPacientes devem se cadastrar usando seu ID de vinculação.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      )
                    : DropdownButtonFormField<UserModel>(
                        initialValue: _selectedPatient,
                        decoration: const InputDecoration(
                          labelText: 'Paciente',
                          prefixIcon: Icon(Icons.person_outlined),
                        ),
                        items: patients
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p.name),
                                ))
                            .toList(),
                        onChanged: (p) =>
                            setState(() => _selectedPatient = p),
                        validator: (_) => _selectedPatient == null
                            ? 'Selecione um paciente'
                            : null,
                      ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) =>
                    const Text('Erro ao carregar pacientes'),
              ),
              const SizedBox(height: 16),

              // ── Título ───────────────────────────────────────────────
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título da Terapia',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (v) => v!.isEmpty ? 'Informe o título' : null,
              ),
              const SizedBox(height: 16),

              // ── Descrição ────────────────────────────────────────────
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (v) => v!.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 16),

              // ── Data / Hora ──────────────────────────────────────────
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: const Text('Data e Hora agendada'),
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
                decoration: const InputDecoration(
                  labelText: 'Instruções para o paciente',
                  prefixIcon: Icon(Icons.list_alt_outlined),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),

              // ── Link ─────────────────────────────────────────────────
              TextFormField(
                controller: _linkCtrl,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Link (opcional)',
                  prefixIcon: Icon(Icons.link),
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
                label: const Text('Enviar Terapia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

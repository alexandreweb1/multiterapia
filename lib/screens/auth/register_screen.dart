import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/brand_mark.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final UserRole? initialRole;
  const RegisterScreen({super.key, this.initialRole});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _therapistIdCtrl = TextEditingController();
  final _registryCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  late UserRole _role;
  Specialty _specialty = Specialty.fono;
  bool _agree = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _role = widget.initialRole ?? UserRole.patient;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _therapistIdCtrl.dispose();
    _registryCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      _snack(AppLocalizations.of(context).registerAcceptTerms);
      return;
    }
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).signUp(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
            name: _nameCtrl.text.trim(),
            role: _role,
            therapistId: _role == UserRole.patient
                ? _therapistIdCtrl.text.trim()
                : null,
            specialty: _role == UserRole.therapist
                ? _specialty
                : Specialty.none,
            professionalRegistry: _role == UserRole.therapist
                ? _registryCtrl.text.trim()
                : null,
            age: _role == UserRole.patient
                ? int.tryParse(_ageCtrl.text.trim())
                : null,
          );
      if (mounted) {
        // Volta ao AuthGate para deixar o redirecionamento por papel acontecer.
        Navigator.of(context).popUntil((r) => r.isFirst);
      }
    } catch (e) {
      if (mounted) {
        _snack(_parseError(AppLocalizations.of(context), e.toString()));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  String _parseError(AppLocalizations t, String error) {
    if (error.contains('email-already-in-use')) return t.errorEmailInUse;
    if (error.contains('weak-password')) return t.errorWeakPassword;
    if (error.contains('invalid-email')) return t.errorInvalidEmail;
    if (error.contains('ID do terapeuta')) return t.errorInvalidTherapistId;
    if (error.contains('permission-denied') ||
        error.contains('permissão negada')) {
      return t.errorPermissionDenied;
    }
    if (error.contains('network-request-failed')) return t.errorNetwork;
    return t.errorSignupGeneric(error);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isTherapist = _role == UserRole.therapist;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header ──────────────────────────────────────────
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const BrandMark(size: 32),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  t.registerCreateAccount,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  t.registerSubtitle,
                  style: TextStyle(color: MtColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 20),

                // ── Toggle Terapeuta/Paciente ────────────────────────
                _RoleSegment(
                  role: _role,
                  onChanged: (r) => setState(() => _role = r),
                ),
                const SizedBox(height: 20),

                // ── Nome ─────────────────────────────────────────────
                _FieldLabel(t.registerFullName),
                TextFormField(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: t.registerFullNameHint,
                  ),
                  validator: (v) => v!.isEmpty ? t.registerNameRequired : null,
                ),
                const SizedBox(height: 16),

                // ── E-mail ───────────────────────────────────────────
                _FieldLabel(
                    isTherapist ? t.registerEmailProfessional : t.loginEmail),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: t.loginEmailHint),
                  validator: (v) => v!.isEmpty ? t.loginEmailRequired : null,
                ),
                const SizedBox(height: 16),

                // ── Especialidade (terapeuta) ────────────────────────
                if (isTherapist) ...[
                  _FieldLabel(t.registerSpecialty),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _SpecChip(
                        label: t.specialtyFonoLabel,
                        selected: _specialty == Specialty.fono,
                        onTap: () =>
                            setState(() => _specialty = Specialty.fono),
                      ),
                      _SpecChip(
                        label: t.specialtyFisioLabel,
                        selected: _specialty == Specialty.fisio,
                        onTap: () =>
                            setState(() => _specialty = Specialty.fisio),
                      ),
                      _SpecChip(
                        label: t.specialtyPsicoLabel,
                        selected: _specialty == Specialty.psico,
                        onTap: () =>
                            setState(() => _specialty = Specialty.psico),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FieldLabel(t.registerRegistry),
                  TextFormField(
                    controller: _registryCtrl,
                    decoration: InputDecoration(
                      hintText: t.registerRegistryHint,
                    ),
                    validator: (v) =>
                        v!.isEmpty ? t.registerRegistryRequired : null,
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Idade + Terapeuta ID (paciente) ──────────────────
                if (!isTherapist) ...[
                  _FieldLabel(t.registerAge),
                  TextFormField(
                    controller: _ageCtrl,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: t.registerAgeHint),
                    validator: (v) =>
                        v!.isEmpty ? t.registerAgeRequired : null,
                  ),
                  const SizedBox(height: 16),
                  _FieldLabel(t.registerTherapistId),
                  TextFormField(
                    controller: _therapistIdCtrl,
                    decoration: InputDecoration(
                      hintText: t.registerTherapistIdHint,
                    ),
                    validator: (v) =>
                        v!.isEmpty ? t.registerTherapistIdRequired : null,
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Senha ────────────────────────────────────────────
                _FieldLabel(t.loginPassword),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: t.registerPasswordHint,
                    suffixIcon: IconButton(
                      iconSize: 18,
                      color: MtColors.muted,
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) =>
                      v!.length < 6 ? t.registerPasswordWeak : null,
                ),
                const SizedBox(height: 16),

                // ── Termos ───────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agree,
                        onChanged: (v) =>
                            setState(() => _agree = v ?? false),
                        activeColor: MtColors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: MtColors.ink, fontSize: 12),
                          children: [
                            TextSpan(text: t.registerTermsPrefix),
                            TextSpan(
                                text: t.registerTermsLink,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            TextSpan(text: t.registerTermsAnd),
                            TextSpan(
                                text: t.registerPrivacyLink,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Botão Criar conta (coral) ────────────────────────
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MtColors.coral,
                  ),
                  icon: _isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.arrow_forward),
                  label: Text(t.registerCreateAccountButton),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: MtColors.muted),
      ),
    );
  }
}

class _RoleSegment extends StatelessWidget {
  final UserRole role;
  final ValueChanged<UserRole> onChanged;

  const _RoleSegment({required this.role, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: MtColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MtColors.border),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _segmentButton(t.registerTherapist, role == UserRole.therapist,
              () => onChanged(UserRole.therapist)),
          _segmentButton(t.registerPatient, role == UserRole.patient,
              () => onChanged(UserRole.patient)),
        ],
      ),
    );
  }

  Widget _segmentButton(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? MtColors.teal : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : MtColors.ink,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SpecChip({
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
          color: selected ? MtColors.teal : MtColors.border,
        ),
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
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

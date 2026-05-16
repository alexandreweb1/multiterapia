import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/brand_mark.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).signIn(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
          );
      if (mounted) {
        // Volta ao AuthGate para que ele faça o redirecionamento por papel.
        Navigator.of(context).popUntil((r) => r.isFirst);
      }
    } catch (e) {
      if (mounted) {
        final t = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_parseError(t, e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _parseError(AppLocalizations t, String error) {
    if (error.contains('user-not-found')) return t.errorUserNotFound;
    if (error.contains('wrong-password') ||
        error.contains('invalid-credential')) {
      return t.errorWrongPassword;
    }
    if (error.contains('invalid-email')) return t.errorInvalidEmail;
    if (error.contains('too-many-requests')) return t.errorTooManyRequests;
    if (error.contains('network-request-failed')) return t.errorNetwork;
    return t.errorLoginGeneric(error);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BrandLockup(markSize: 32),
                ),
                const SizedBox(height: 28),

                // ── Heading ─────────────────────────────────────────
                Text(
                  t.loginWelcomeBack,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.loginSubtitle,
                  style: TextStyle(color: MtColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 32),

                // ── E-mail ──────────────────────────────────────────
                _FieldLabel(t.loginEmail),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail_outline,
                        color: MtColors.muted, size: 20),
                    hintText: t.loginEmailHint,
                  ),
                  validator: (v) => v!.isEmpty ? t.loginEmailRequired : null,
                ),
                const SizedBox(height: 18),

                // ── Senha ───────────────────────────────────────────
                _FieldLabel(t.loginPassword),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: MtColors.muted, size: 20),
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
                  validator: (v) => v!.isEmpty ? t.loginPasswordRequired : null,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _showForgotPassword,
                    style: TextButton.styleFrom(
                      foregroundColor: MtColors.teal,
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    child: Text(t.loginForgotPassword),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Botão Entrar ────────────────────────────────────
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(t.loginSignIn),
                ),
                const SizedBox(height: 24),

                // ── Divisor "ou continue com" ───────────────────────
                Row(
                  children: [
                    Expanded(
                        child: Divider(color: MtColors.border)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        t.loginOrContinue,
                        style: TextStyle(
                            color: MtColors.muted, fontSize: 12),
                      ),
                    ),
                    Expanded(
                        child: Divider(color: MtColors.border)),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Botões sociais (placeholder) ────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        label: 'Google',
                        leading: const _GoogleG(),
                        onTap: _socialNotImplemented,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SocialButton(
                        label: 'Apple',
                        leading: const Icon(Icons.apple,
                            color: MtColors.ink, size: 22),
                        onTap: _socialNotImplemented,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Cadastrar ───────────────────────────────────────
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: t.loginNoAccountPrefix,
                      style: TextStyle(
                          color: MtColors.muted, fontSize: 13),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterScreen()),
                            ),
                            child: Text(
                              t.loginSignUp,
                              style: const TextStyle(
                                color: MtColors.coral,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _socialNotImplemented() {
    final t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.loginSocialNotImplemented)),
    );
  }

  void _showForgotPassword() {
    final t = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.loginForgotPassword),
        content: Text(t.loginForgotDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.commonOk),
          ),
        ],
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
          color: MtColors.muted,
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget leading;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.leading,
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
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading,
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: MtColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleG extends StatelessWidget {
  const _GoogleG();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4285F4),
        ),
      ),
    );
  }
}

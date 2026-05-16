import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'models/user_model.dart';
import 'providers/auth_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/patient/patient_dashboard.dart';
import 'screens/splash_screen.dart';
import 'screens/therapist/therapist_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MultiterapiaApp()));
}

class MultiterapiaApp extends StatelessWidget {
  const MultiterapiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiterapia',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('pt', 'BR'),
    );
  }
}

// ── Auth Gate ────────────────────────────────────────────────────────────────

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (firebaseUser) {
        if (firebaseUser == null) return const OnboardingScreen();
        return UserRoleGate(userId: firebaseUser.uid);
      },
      loading: () => const SplashScreen(),
      error: (_, _) => const OnboardingScreen(),
    );
  }
}

// ── Role Gate: carrega o perfil do Firestore e redireciona ────────────────────

class UserRoleGate extends ConsumerWidget {
  final String userId;
  const UserRoleGate({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (userModel) {
        if (userModel == null) return const _IncompleteProfileScreen();
        return userModel.role == UserRole.therapist
            ? const TherapistDashboard()
            : const PatientDashboard();
      },
      loading: () => const SplashScreen(),
      error: (_, _) => const OnboardingScreen(),
    );
  }
}

/// Mostrada quando o usuário está autenticado no Firebase Auth, mas não há
/// documento correspondente no Firestore (cadastro interrompido / regras).
class _IncompleteProfileScreen extends ConsumerWidget {
  const _IncompleteProfileScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.error_outline, size: 56),
              const SizedBox(height: 16),
              Text(
                'Cadastro incompleto',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Sua conta existe na autenticação, mas o perfil não foi gravado no banco. '
                'Saia e crie o cadastro novamente.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(authServiceProvider).signOut(),
                child: const Text('Sair'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

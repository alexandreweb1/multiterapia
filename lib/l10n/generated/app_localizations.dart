import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Multiterapia'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In pt, this message translates to:
  /// **'cuidado conectado'**
  String get appTagline;

  /// No description provided for @commonLoading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando…'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get commonError;

  /// No description provided for @commonOk.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get commonRetry;

  /// No description provided for @splashTagline.
  ///
  /// In pt, this message translates to:
  /// **'cuidado conectado'**
  String get splashTagline;

  /// No description provided for @onboardingHowToEnter.
  ///
  /// In pt, this message translates to:
  /// **'Como você quer entrar?'**
  String get onboardingHowToEnter;

  /// No description provided for @onboardingChooseProfile.
  ///
  /// In pt, this message translates to:
  /// **'Escolha seu perfil de acesso'**
  String get onboardingChooseProfile;

  /// No description provided for @onboardingImTherapist.
  ///
  /// In pt, this message translates to:
  /// **'Sou terapeuta'**
  String get onboardingImTherapist;

  /// No description provided for @onboardingTherapistSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar pacientes e sessões'**
  String get onboardingTherapistSubtitle;

  /// No description provided for @onboardingImPatient.
  ///
  /// In pt, this message translates to:
  /// **'Sou paciente'**
  String get onboardingImPatient;

  /// No description provided for @onboardingPatientSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhar minha jornada'**
  String get onboardingPatientSubtitle;

  /// No description provided for @onboardingHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já tenho conta — Entrar'**
  String get onboardingHaveAccount;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo(a)\nde volta.'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Entre para continuar seu cuidado.'**
  String get loginSubtitle;

  /// No description provided for @loginEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get loginEmail;

  /// No description provided for @loginEmailHint.
  ///
  /// In pt, this message translates to:
  /// **'seu@email.com'**
  String get loginEmailHint;

  /// No description provided for @loginEmailRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o e-mail'**
  String get loginEmailRequired;

  /// No description provided for @loginPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get loginPassword;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a senha'**
  String get loginPasswordRequired;

  /// No description provided for @loginForgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get loginForgotPassword;

  /// No description provided for @loginForgotDialogBody.
  ///
  /// In pt, this message translates to:
  /// **'Em breve será possível recuperar a senha por e-mail.'**
  String get loginForgotDialogBody;

  /// No description provided for @loginSignIn.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get loginSignIn;

  /// No description provided for @loginOrContinue.
  ///
  /// In pt, this message translates to:
  /// **'ou continue com'**
  String get loginOrContinue;

  /// No description provided for @loginNoAccountPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Não tem conta? '**
  String get loginNoAccountPrefix;

  /// No description provided for @loginSignUp.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se'**
  String get loginSignUp;

  /// No description provided for @loginSocialNotImplemented.
  ///
  /// In pt, this message translates to:
  /// **'Login social ainda não implementado.'**
  String get loginSocialNotImplemented;

  /// No description provided for @errorUserNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Usuário não encontrado.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In pt, this message translates to:
  /// **'E-mail ou senha incorretos.'**
  String get errorWrongPassword;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail inválido.'**
  String get errorInvalidEmail;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Tente novamente em instantes.'**
  String get errorTooManyRequests;

  /// No description provided for @errorNetwork.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão. Verifique sua internet.'**
  String get errorNetwork;

  /// No description provided for @errorLoginGeneric.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao fazer login: {message}'**
  String errorLoginGeneric(String message);

  /// No description provided for @errorEmailInUse.
  ///
  /// In pt, this message translates to:
  /// **'E-mail já cadastrado.'**
  String get errorEmailInUse;

  /// No description provided for @errorWeakPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha fraca (mínimo 6 caracteres).'**
  String get errorWeakPassword;

  /// No description provided for @errorInvalidTherapistId.
  ///
  /// In pt, this message translates to:
  /// **'ID do terapeuta inválido.'**
  String get errorInvalidTherapistId;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In pt, this message translates to:
  /// **'Permissão negada pelo Firestore. Verifique as regras (firestore.rules) publicadas no console.'**
  String get errorPermissionDenied;

  /// No description provided for @errorSignupGeneric.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao cadastrar: {message}'**
  String errorSignupGeneric(String message);

  /// No description provided for @registerCreateAccount.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get registerCreateAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece sua jornada em poucos passos.'**
  String get registerSubtitle;

  /// No description provided for @registerFullName.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get registerFullName;

  /// No description provided for @registerFullNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Como você quer ser chamado(a)'**
  String get registerFullNameHint;

  /// No description provided for @registerNameRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe seu nome'**
  String get registerNameRequired;

  /// No description provided for @registerEmailProfessional.
  ///
  /// In pt, this message translates to:
  /// **'E-mail profissional'**
  String get registerEmailProfessional;

  /// No description provided for @registerSpecialty.
  ///
  /// In pt, this message translates to:
  /// **'Especialidade'**
  String get registerSpecialty;

  /// No description provided for @registerRegistry.
  ///
  /// In pt, this message translates to:
  /// **'Registro profissional'**
  String get registerRegistry;

  /// No description provided for @registerRegistryHint.
  ///
  /// In pt, this message translates to:
  /// **'CRFa 5/12345'**
  String get registerRegistryHint;

  /// No description provided for @registerRegistryRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe seu registro'**
  String get registerRegistryRequired;

  /// No description provided for @registerAge.
  ///
  /// In pt, this message translates to:
  /// **'Idade'**
  String get registerAge;

  /// No description provided for @registerAgeHint.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 28'**
  String get registerAgeHint;

  /// No description provided for @registerAgeRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a idade'**
  String get registerAgeRequired;

  /// No description provided for @registerTherapistId.
  ///
  /// In pt, this message translates to:
  /// **'ID do terapeuta'**
  String get registerTherapistId;

  /// No description provided for @registerTherapistIdHint.
  ///
  /// In pt, this message translates to:
  /// **'Cole o ID fornecido pelo seu terapeuta'**
  String get registerTherapistIdHint;

  /// No description provided for @registerTherapistIdRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o ID do terapeuta'**
  String get registerTherapistIdRequired;

  /// No description provided for @registerPasswordHint.
  ///
  /// In pt, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get registerPasswordHint;

  /// No description provided for @registerPasswordWeak.
  ///
  /// In pt, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get registerPasswordWeak;

  /// No description provided for @registerTermsPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Concordo com os '**
  String get registerTermsPrefix;

  /// No description provided for @registerTermsLink.
  ///
  /// In pt, this message translates to:
  /// **'termos de uso'**
  String get registerTermsLink;

  /// No description provided for @registerTermsAnd.
  ///
  /// In pt, this message translates to:
  /// **' e a '**
  String get registerTermsAnd;

  /// No description provided for @registerPrivacyLink.
  ///
  /// In pt, this message translates to:
  /// **'política de privacidade.'**
  String get registerPrivacyLink;

  /// No description provided for @registerAcceptTerms.
  ///
  /// In pt, this message translates to:
  /// **'Aceite os termos de uso para continuar.'**
  String get registerAcceptTerms;

  /// No description provided for @registerTherapist.
  ///
  /// In pt, this message translates to:
  /// **'Terapeuta'**
  String get registerTherapist;

  /// No description provided for @registerPatient.
  ///
  /// In pt, this message translates to:
  /// **'Paciente'**
  String get registerPatient;

  /// No description provided for @registerCreateAccountButton.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get registerCreateAccountButton;

  /// No description provided for @specialtyFonoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Fonoaudiologia'**
  String get specialtyFonoLabel;

  /// No description provided for @specialtyFisioLabel.
  ///
  /// In pt, this message translates to:
  /// **'Fisioterapia'**
  String get specialtyFisioLabel;

  /// No description provided for @specialtyPsicoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Psicologia'**
  String get specialtyPsicoLabel;

  /// No description provided for @specialtyNoneLabel.
  ///
  /// In pt, this message translates to:
  /// **'—'**
  String get specialtyNoneLabel;

  /// No description provided for @specialtyFonoShort.
  ///
  /// In pt, this message translates to:
  /// **'Fono'**
  String get specialtyFonoShort;

  /// No description provided for @specialtyFisioShort.
  ///
  /// In pt, this message translates to:
  /// **'Fisio'**
  String get specialtyFisioShort;

  /// No description provided for @specialtyPsicoShort.
  ///
  /// In pt, this message translates to:
  /// **'Psico'**
  String get specialtyPsicoShort;

  /// No description provided for @specialtyNoneShort.
  ///
  /// In pt, this message translates to:
  /// **'—'**
  String get specialtyNoneShort;

  /// No description provided for @greetingMorning.
  ///
  /// In pt, this message translates to:
  /// **'Bom dia,'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In pt, this message translates to:
  /// **'Boa tarde,'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In pt, this message translates to:
  /// **'Boa noite,'**
  String get greetingEvening;

  /// No description provided for @today.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get today;

  /// No description provided for @statSessions.
  ///
  /// In pt, this message translates to:
  /// **'sessões'**
  String get statSessions;

  /// No description provided for @statPatients.
  ///
  /// In pt, this message translates to:
  /// **'pacientes'**
  String get statPatients;

  /// No description provided for @statScheduled.
  ///
  /// In pt, this message translates to:
  /// **'previstas'**
  String get statScheduled;

  /// No description provided for @nextSessions.
  ///
  /// In pt, this message translates to:
  /// **'Próximas sessões'**
  String get nextSessions;

  /// No description provided for @seeWeek.
  ///
  /// In pt, this message translates to:
  /// **'Ver semana →'**
  String get seeWeek;

  /// No description provided for @noSessionsToday.
  ///
  /// In pt, this message translates to:
  /// **'Sem sessões agendadas para hoje'**
  String get noSessionsToday;

  /// No description provided for @errorLoadingSessions.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar sessões'**
  String get errorLoadingSessions;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar perfil'**
  String get errorLoadingProfile;

  /// No description provided for @copyLinkId.
  ///
  /// In pt, this message translates to:
  /// **'Copiar meu ID de vinculação'**
  String get copyLinkId;

  /// No description provided for @copyLinkIdSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhe com seus pacientes para que eles se cadastrem'**
  String get copyLinkIdSubtitle;

  /// No description provided for @idCopied.
  ///
  /// In pt, this message translates to:
  /// **'ID copiado!'**
  String get idCopied;

  /// No description provided for @signOut.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get signOut;

  /// No description provided for @noNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Sem notificações por enquanto.'**
  String get noNotifications;

  /// No description provided for @sessionStatusInProgress.
  ///
  /// In pt, this message translates to:
  /// **'Em andamento'**
  String get sessionStatusInProgress;

  /// No description provided for @sessionStatusLate.
  ///
  /// In pt, this message translates to:
  /// **'Atrasada'**
  String get sessionStatusLate;

  /// No description provided for @sessionStatusConfirmed.
  ///
  /// In pt, this message translates to:
  /// **'Confirmada'**
  String get sessionStatusConfirmed;

  /// No description provided for @sessionInHours.
  ///
  /// In pt, this message translates to:
  /// **'em {hours}h'**
  String sessionInHours(int hours);

  /// No description provided for @sessionInMinutes.
  ///
  /// In pt, this message translates to:
  /// **'em {minutes}min'**
  String sessionInMinutes(int minutes);

  /// No description provided for @agendaWeek.
  ///
  /// In pt, this message translates to:
  /// **'semana {week}'**
  String agendaWeek(int week);

  /// No description provided for @agendaNoSessionsDay.
  ///
  /// In pt, this message translates to:
  /// **'Sem sessões neste dia.'**
  String get agendaNoSessionsDay;

  /// No description provided for @agendaSessionsCountZero.
  ///
  /// In pt, this message translates to:
  /// **'sem sessões'**
  String get agendaSessionsCountZero;

  /// No description provided for @agendaSessionsCountOne.
  ///
  /// In pt, this message translates to:
  /// **'1 sessão'**
  String get agendaSessionsCountOne;

  /// No description provided for @agendaSessionsCountMany.
  ///
  /// In pt, this message translates to:
  /// **'{count} sessões'**
  String agendaSessionsCountMany(int count);

  /// No description provided for @agendaBlockTime.
  ///
  /// In pt, this message translates to:
  /// **'Bloquear horário'**
  String get agendaBlockTime;

  /// No description provided for @agendaBlockNotImplemented.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueio de horário ainda não implementado.'**
  String get agendaBlockNotImplemented;

  /// No description provided for @agendaFreeSlot.
  ///
  /// In pt, this message translates to:
  /// **'Você tem horário livre entre {start} e {end}.'**
  String agendaFreeSlot(String start, String end);

  /// No description provided for @agendaLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar agenda'**
  String get agendaLoadingError;

  /// No description provided for @dowMon.
  ///
  /// In pt, this message translates to:
  /// **'SEG'**
  String get dowMon;

  /// No description provided for @dowTue.
  ///
  /// In pt, this message translates to:
  /// **'TER'**
  String get dowTue;

  /// No description provided for @dowWed.
  ///
  /// In pt, this message translates to:
  /// **'QUA'**
  String get dowWed;

  /// No description provided for @dowThu.
  ///
  /// In pt, this message translates to:
  /// **'QUI'**
  String get dowThu;

  /// No description provided for @dowFri.
  ///
  /// In pt, this message translates to:
  /// **'SEX'**
  String get dowFri;

  /// No description provided for @dowSat.
  ///
  /// In pt, this message translates to:
  /// **'SÁB'**
  String get dowSat;

  /// No description provided for @dowSun.
  ///
  /// In pt, this message translates to:
  /// **'DOM'**
  String get dowSun;

  /// No description provided for @patientsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pacientes'**
  String get patientsTitle;

  /// No description provided for @patientsSearchHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar paciente…'**
  String get patientsSearchHint;

  /// No description provided for @patientsFilterAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get patientsFilterAll;

  /// No description provided for @patientsEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum paciente vinculado.\nCompartilhe seu ID para que eles se cadastrem.'**
  String get patientsEmpty;

  /// No description provided for @patientsEmptyFiltered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum paciente corresponde aos filtros.'**
  String get patientsEmptyFiltered;

  /// No description provided for @patientsLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar pacientes'**
  String get patientsLoadingError;

  /// No description provided for @patientsAdvancedFiltersSoon.
  ///
  /// In pt, this message translates to:
  /// **'Filtros avançados em breve.'**
  String get patientsAdvancedFiltersSoon;

  /// No description provided for @patientsNextShort.
  ///
  /// In pt, this message translates to:
  /// **'Próx.'**
  String get patientsNextShort;

  /// No description provided for @patientAgeYears.
  ///
  /// In pt, this message translates to:
  /// **'{age} anos'**
  String patientAgeYears(int age);

  /// No description provided for @patientAgeUnknown.
  ///
  /// In pt, this message translates to:
  /// **'idade —'**
  String get patientAgeUnknown;

  /// No description provided for @patientsToday.
  ///
  /// In pt, this message translates to:
  /// **'hoje'**
  String get patientsToday;

  /// No description provided for @patientsTomorrow.
  ///
  /// In pt, this message translates to:
  /// **'amanhã'**
  String get patientsTomorrow;

  /// No description provided for @patientScreenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Paciente'**
  String get patientScreenTitle;

  /// No description provided for @patientChatTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Mensagens'**
  String get patientChatTooltip;

  /// No description provided for @patientInTreatment.
  ///
  /// In pt, this message translates to:
  /// **'Em tratamento · {duration}'**
  String patientInTreatment(String duration);

  /// No description provided for @patientEvolution8w.
  ///
  /// In pt, this message translates to:
  /// **'Evolução · 8 semanas'**
  String get patientEvolution8w;

  /// No description provided for @patientMetricPhonemes.
  ///
  /// In pt, this message translates to:
  /// **'fonemas'**
  String get patientMetricPhonemes;

  /// No description provided for @patientMetricMobility.
  ///
  /// In pt, this message translates to:
  /// **'mobilidade'**
  String get patientMetricMobility;

  /// No description provided for @patientMetricEngagement.
  ///
  /// In pt, this message translates to:
  /// **'engajamento'**
  String get patientMetricEngagement;

  /// No description provided for @patientKpiSessions.
  ///
  /// In pt, this message translates to:
  /// **'sessões'**
  String get patientKpiSessions;

  /// No description provided for @patientKpiFrequency.
  ///
  /// In pt, this message translates to:
  /// **'frequência'**
  String get patientKpiFrequency;

  /// No description provided for @patientKpiProgress.
  ///
  /// In pt, this message translates to:
  /// **'progresso'**
  String get patientKpiProgress;

  /// No description provided for @patientStartSession.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar sessão'**
  String get patientStartSession;

  /// No description provided for @patientStartSessionError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao iniciar sessão: {error}'**
  String patientStartSessionError(String error);

  /// No description provided for @durationLessThanMonth.
  ///
  /// In pt, this message translates to:
  /// **'menos de 1 mês'**
  String get durationLessThanMonth;

  /// No description provided for @durationOneMonth.
  ///
  /// In pt, this message translates to:
  /// **'1 mês'**
  String get durationOneMonth;

  /// No description provided for @durationMonths.
  ///
  /// In pt, this message translates to:
  /// **'{n} meses'**
  String durationMonths(int n);

  /// No description provided for @sessionTitleNumbered.
  ///
  /// In pt, this message translates to:
  /// **'Sessão #{n}'**
  String sessionTitleNumbered(String n);

  /// No description provided for @sessionStatusOngoing.
  ///
  /// In pt, this message translates to:
  /// **'em andamento · {time}'**
  String sessionStatusOngoing(String time);

  /// No description provided for @sessionStatusScheduled.
  ///
  /// In pt, this message translates to:
  /// **'agendada · {time}'**
  String sessionStatusScheduled(String time);

  /// No description provided for @sessionSaveNotesTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Salvar notas'**
  String get sessionSaveNotesTooltip;

  /// No description provided for @sessionLivePill.
  ///
  /// In pt, this message translates to:
  /// **'ao vivo'**
  String get sessionLivePill;

  /// No description provided for @sessionNotesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Anotações da sessão'**
  String get sessionNotesTitle;

  /// No description provided for @sessionNotesHint.
  ///
  /// In pt, this message translates to:
  /// **'Escreva observações sobre a sessão…'**
  String get sessionNotesHint;

  /// No description provided for @sessionNotesEdited.
  ///
  /// In pt, this message translates to:
  /// **'Editado {when}'**
  String sessionNotesEdited(String when);

  /// No description provided for @sessionExercisesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Exercícios atribuídos'**
  String get sessionExercisesTitle;

  /// No description provided for @sessionExerciseBreathing.
  ///
  /// In pt, this message translates to:
  /// **'Respiração diafragmática'**
  String get sessionExerciseBreathing;

  /// No description provided for @sessionExerciseBreathingSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'5x ao dia · 5 min'**
  String get sessionExerciseBreathingSubtitle;

  /// No description provided for @sessionExerciseReading.
  ///
  /// In pt, this message translates to:
  /// **'Leitura em voz alta'**
  String get sessionExerciseReading;

  /// No description provided for @sessionExerciseReadingSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'diário · 10 min'**
  String get sessionExerciseReadingSubtitle;

  /// No description provided for @sessionFinish.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar sessão'**
  String get sessionFinish;

  /// No description provided for @sessionStart.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar sessão'**
  String get sessionStart;

  /// No description provided for @sessionFinished.
  ///
  /// In pt, this message translates to:
  /// **'Sessão finalizada.'**
  String get sessionFinished;

  /// No description provided for @sessionNotesSaved.
  ///
  /// In pt, this message translates to:
  /// **'Notas salvas.'**
  String get sessionNotesSaved;

  /// No description provided for @relativeJustNow.
  ///
  /// In pt, this message translates to:
  /// **'há instantes'**
  String get relativeJustNow;

  /// No description provided for @relativeMinutes.
  ///
  /// In pt, this message translates to:
  /// **'há {n} min'**
  String relativeMinutes(int n);

  /// No description provided for @relativeHours.
  ///
  /// In pt, this message translates to:
  /// **'há {n}h'**
  String relativeHours(int n);

  /// No description provided for @taskNew.
  ///
  /// In pt, this message translates to:
  /// **'Nova Terapia'**
  String get taskNew;

  /// No description provided for @taskPatient.
  ///
  /// In pt, this message translates to:
  /// **'Paciente'**
  String get taskPatient;

  /// No description provided for @taskNoPatients.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum paciente disponível.\nPacientes devem se cadastrar usando seu ID de vinculação.'**
  String get taskNoPatients;

  /// No description provided for @taskSelectPatient.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um paciente'**
  String get taskSelectPatient;

  /// No description provided for @taskTitleLabel.
  ///
  /// In pt, this message translates to:
  /// **'Título da Terapia'**
  String get taskTitleLabel;

  /// No description provided for @taskTitleRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe o título'**
  String get taskTitleRequired;

  /// No description provided for @taskDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get taskDescription;

  /// No description provided for @taskDescriptionRequired.
  ///
  /// In pt, this message translates to:
  /// **'Informe a descrição'**
  String get taskDescriptionRequired;

  /// No description provided for @taskDatetime.
  ///
  /// In pt, this message translates to:
  /// **'Data e Hora agendada'**
  String get taskDatetime;

  /// No description provided for @taskInstructions.
  ///
  /// In pt, this message translates to:
  /// **'Instruções para o paciente'**
  String get taskInstructions;

  /// No description provided for @taskLink.
  ///
  /// In pt, this message translates to:
  /// **'Link (opcional)'**
  String get taskLink;

  /// No description provided for @taskSend.
  ///
  /// In pt, this message translates to:
  /// **'Enviar Terapia'**
  String get taskSend;

  /// No description provided for @taskSendSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Terapia enviada com sucesso!'**
  String get taskSendSuccess;

  /// No description provided for @taskSendError.
  ///
  /// In pt, this message translates to:
  /// **'Erro: {error}'**
  String taskSendError(String error);

  /// No description provided for @taskLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar pacientes'**
  String get taskLoadingError;

  /// No description provided for @patientHi.
  ///
  /// In pt, this message translates to:
  /// **'Olá,'**
  String get patientHi;

  /// No description provided for @patientLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar'**
  String get patientLoadingError;

  /// No description provided for @patientNextSessionKicker.
  ///
  /// In pt, this message translates to:
  /// **'SUA PRÓXIMA SESSÃO'**
  String get patientNextSessionKicker;

  /// No description provided for @patientWithTherapist.
  ///
  /// In pt, this message translates to:
  /// **'com {therapist} · {specialty}'**
  String patientWithTherapist(String therapist, String specialty);

  /// No description provided for @patientYourTherapist.
  ///
  /// In pt, this message translates to:
  /// **'seu terapeuta'**
  String get patientYourTherapist;

  /// No description provided for @patientTodayAt.
  ///
  /// In pt, this message translates to:
  /// **'Hoje, {time}'**
  String patientTodayAt(String time);

  /// No description provided for @videoRoomSoon.
  ///
  /// In pt, this message translates to:
  /// **'Sala de vídeo em breve.'**
  String get videoRoomSoon;

  /// No description provided for @patientJoinRoom.
  ///
  /// In pt, this message translates to:
  /// **'Entrar na sala'**
  String get patientJoinRoom;

  /// No description provided for @patientNoSessionKicker.
  ///
  /// In pt, this message translates to:
  /// **'NENHUMA SESSÃO AGENDADA'**
  String get patientNoSessionKicker;

  /// No description provided for @patientAllQuiet.
  ///
  /// In pt, this message translates to:
  /// **'Tudo tranquilo por aqui.'**
  String get patientAllQuiet;

  /// No description provided for @patientLinkTherapist.
  ///
  /// In pt, this message translates to:
  /// **'Vincule-se a um terapeuta para começar.'**
  String get patientLinkTherapist;

  /// No description provided for @patientTherapistWillSchedule.
  ///
  /// In pt, this message translates to:
  /// **'Seu terapeuta agendará a próxima quando estiver disponível.'**
  String get patientTherapistWillSchedule;

  /// No description provided for @patientActivitiesForToday.
  ///
  /// In pt, this message translates to:
  /// **'Atividades para hoje'**
  String get patientActivitiesForToday;

  /// No description provided for @patientNoActivities.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma atividade ainda.'**
  String get patientNoActivities;

  /// No description provided for @patientActivitiesLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar atividades'**
  String get patientActivitiesLoadingError;

  /// No description provided for @taskCompleted.
  ///
  /// In pt, this message translates to:
  /// **'concluído'**
  String get taskCompleted;

  /// No description provided for @taskPending.
  ///
  /// In pt, this message translates to:
  /// **'pendente'**
  String get taskPending;

  /// No description provided for @taskDefaultActivity.
  ///
  /// In pt, this message translates to:
  /// **'atividade'**
  String get taskDefaultActivity;

  /// No description provided for @tabCalendarTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua agenda'**
  String get tabCalendarTitle;

  /// No description provided for @tabCalendarMsg.
  ///
  /// In pt, this message translates to:
  /// **'Em breve, você verá aqui todas as suas próximas sessões agendadas com {therapist}.'**
  String tabCalendarMsg(String therapist);

  /// No description provided for @placeholderYourTherapist.
  ///
  /// In pt, this message translates to:
  /// **'seu terapeuta'**
  String get placeholderYourTherapist;

  /// No description provided for @placeholderDr.
  ///
  /// In pt, this message translates to:
  /// **'Dra./Dr.'**
  String get placeholderDr;

  /// No description provided for @evolutionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua evolução'**
  String get evolutionTitle;

  /// No description provided for @evolutionSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe sua adesão ao tratamento.'**
  String get evolutionSubtitle;

  /// No description provided for @evolutionAdherence.
  ///
  /// In pt, this message translates to:
  /// **'de adesão'**
  String get evolutionAdherence;

  /// No description provided for @evolutionCompleted.
  ///
  /// In pt, this message translates to:
  /// **'concluídas'**
  String get evolutionCompleted;

  /// No description provided for @evolutionPending.
  ///
  /// In pt, this message translates to:
  /// **'pendentes'**
  String get evolutionPending;

  /// No description provided for @profilePrivacy.
  ///
  /// In pt, this message translates to:
  /// **'Privacidade'**
  String get profilePrivacy;

  /// No description provided for @profileHelp.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda'**
  String get profileHelp;

  /// No description provided for @profileSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get profileSettings;

  /// No description provided for @chatOnline.
  ///
  /// In pt, this message translates to:
  /// **'online'**
  String get chatOnline;

  /// No description provided for @chatNoMessages.
  ///
  /// In pt, this message translates to:
  /// **'Diga olá!'**
  String get chatNoMessages;

  /// No description provided for @chatSendFailed.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao enviar: {error}'**
  String chatSendFailed(String error);

  /// No description provided for @chatLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar mensagens'**
  String get chatLoadingError;

  /// No description provided for @chatTodaySeparator.
  ///
  /// In pt, this message translates to:
  /// **'— hoje, {time} —'**
  String chatTodaySeparator(String time);

  /// No description provided for @chatDateSeparator.
  ///
  /// In pt, this message translates to:
  /// **'— {date} —'**
  String chatDateSeparator(String date);

  /// No description provided for @chatInputHint.
  ///
  /// In pt, this message translates to:
  /// **'Escreva uma mensagem…'**
  String get chatInputHint;

  /// No description provided for @profileIncomplete.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro incompleto'**
  String get profileIncomplete;

  /// No description provided for @profileIncompleteBody.
  ///
  /// In pt, this message translates to:
  /// **'Sua conta existe na autenticação, mas o perfil não foi gravado no banco. Saia e crie o cadastro novamente.'**
  String get profileIncompleteBody;

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageDesc.
  ///
  /// In pt, this message translates to:
  /// **'Escolha o idioma do aplicativo'**
  String get settingsLanguageDesc;

  /// No description provided for @settingsLanguageAutoNote.
  ///
  /// In pt, this message translates to:
  /// **'Automático: Brasil usa Português, outros países usam Inglês.'**
  String get settingsLanguageAutoNote;

  /// No description provided for @languagePt.
  ///
  /// In pt, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePt;

  /// No description provided for @languageEn.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get languageEn;

  /// No description provided for @languageEs.
  ///
  /// In pt, this message translates to:
  /// **'Espanhol'**
  String get languageEs;

  /// No description provided for @settingsAppVersion.
  ///
  /// In pt, this message translates to:
  /// **'Versão do aplicativo'**
  String get settingsAppVersion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

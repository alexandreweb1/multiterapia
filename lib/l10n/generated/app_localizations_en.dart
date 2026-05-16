// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Multiterapia';

  @override
  String get appTagline => 'connected care';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonError => 'Error';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonRetry => 'Try again';

  @override
  String get splashTagline => 'connected care';

  @override
  String get onboardingHowToEnter => 'How would you like to sign in?';

  @override
  String get onboardingChooseProfile => 'Choose your access profile';

  @override
  String get onboardingImTherapist => 'I\'m a therapist';

  @override
  String get onboardingTherapistSubtitle => 'Manage patients and sessions';

  @override
  String get onboardingImPatient => 'I\'m a patient';

  @override
  String get onboardingPatientSubtitle => 'Follow my care journey';

  @override
  String get onboardingHaveAccount => 'I already have an account — Sign in';

  @override
  String get loginWelcomeBack => 'Welcome\nback.';

  @override
  String get loginSubtitle => 'Sign in to continue your care.';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginEmailHint => 'you@email.com';

  @override
  String get loginEmailRequired => 'Enter your email';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginPasswordRequired => 'Enter your password';

  @override
  String get loginForgotPassword => 'Forgot password';

  @override
  String get loginForgotDialogBody => 'Password recovery by email coming soon.';

  @override
  String get loginSignIn => 'Sign in';

  @override
  String get loginOrContinue => 'or continue with';

  @override
  String get loginNoAccountPrefix => 'Don\'t have an account? ';

  @override
  String get loginSignUp => 'Sign up';

  @override
  String get loginSocialNotImplemented => 'Social login not implemented yet.';

  @override
  String get errorUserNotFound => 'User not found.';

  @override
  String get errorWrongPassword => 'Incorrect email or password.';

  @override
  String get errorInvalidEmail => 'Invalid email.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Try again in a moment.';

  @override
  String get errorNetwork => 'No connection. Check your internet.';

  @override
  String errorLoginGeneric(String message) {
    return 'Sign-in error: $message';
  }

  @override
  String get errorEmailInUse => 'Email already in use.';

  @override
  String get errorWeakPassword => 'Weak password (minimum 6 characters).';

  @override
  String get errorInvalidTherapistId => 'Invalid therapist ID.';

  @override
  String get errorPermissionDenied =>
      'Permission denied by Firestore. Check the rules (firestore.rules) published in the console.';

  @override
  String errorSignupGeneric(String message) {
    return 'Sign-up error: $message';
  }

  @override
  String get registerCreateAccount => 'Create account';

  @override
  String get registerSubtitle => 'Start your journey in a few steps.';

  @override
  String get registerFullName => 'Full name';

  @override
  String get registerFullNameHint => 'What should we call you?';

  @override
  String get registerNameRequired => 'Enter your name';

  @override
  String get registerEmailProfessional => 'Professional email';

  @override
  String get registerSpecialty => 'Specialty';

  @override
  String get registerRegistry => 'Professional registry';

  @override
  String get registerRegistryHint => 'License #12345';

  @override
  String get registerRegistryRequired => 'Enter your registry';

  @override
  String get registerAge => 'Age';

  @override
  String get registerAgeHint => 'e.g. 28';

  @override
  String get registerAgeRequired => 'Enter your age';

  @override
  String get registerTherapistId => 'Therapist ID';

  @override
  String get registerTherapistIdHint =>
      'Paste the ID provided by your therapist';

  @override
  String get registerTherapistIdRequired => 'Enter the therapist ID';

  @override
  String get registerPasswordHint => 'At least 6 characters';

  @override
  String get registerPasswordWeak => 'At least 6 characters';

  @override
  String get registerTermsPrefix => 'I agree with the ';

  @override
  String get registerTermsLink => 'terms of use';

  @override
  String get registerTermsAnd => ' and the ';

  @override
  String get registerPrivacyLink => 'privacy policy.';

  @override
  String get registerAcceptTerms => 'Accept the terms of use to continue.';

  @override
  String get registerTherapist => 'Therapist';

  @override
  String get registerPatient => 'Patient';

  @override
  String get registerCreateAccountButton => 'Create account';

  @override
  String get specialtyFonoLabel => 'Speech therapy';

  @override
  String get specialtyFisioLabel => 'Physical therapy';

  @override
  String get specialtyPsicoLabel => 'Psychology';

  @override
  String get specialtyNoneLabel => '—';

  @override
  String get specialtyFonoShort => 'Speech';

  @override
  String get specialtyFisioShort => 'Physio';

  @override
  String get specialtyPsicoShort => 'Psych';

  @override
  String get specialtyNoneShort => '—';

  @override
  String get greetingMorning => 'Good morning,';

  @override
  String get greetingAfternoon => 'Good afternoon,';

  @override
  String get greetingEvening => 'Good evening,';

  @override
  String get today => 'Today';

  @override
  String get statSessions => 'sessions';

  @override
  String get statPatients => 'patients';

  @override
  String get statScheduled => 'scheduled';

  @override
  String get nextSessions => 'Upcoming sessions';

  @override
  String get seeWeek => 'See week →';

  @override
  String get noSessionsToday => 'No sessions scheduled for today';

  @override
  String get errorLoadingSessions => 'Error loading sessions';

  @override
  String get errorLoadingProfile => 'Error loading profile';

  @override
  String get copyLinkId => 'Copy my linking ID';

  @override
  String get copyLinkIdSubtitle =>
      'Share with your patients so they can sign up';

  @override
  String get idCopied => 'ID copied!';

  @override
  String get signOut => 'Sign out';

  @override
  String get noNotifications => 'No notifications yet.';

  @override
  String get sessionStatusInProgress => 'In progress';

  @override
  String get sessionStatusLate => 'Late';

  @override
  String get sessionStatusConfirmed => 'Confirmed';

  @override
  String sessionInHours(int hours) {
    return 'in ${hours}h';
  }

  @override
  String sessionInMinutes(int minutes) {
    return 'in ${minutes}min';
  }

  @override
  String agendaWeek(int week) {
    return 'week $week';
  }

  @override
  String get agendaNoSessionsDay => 'No sessions on this day.';

  @override
  String get agendaSessionsCountZero => 'no sessions';

  @override
  String get agendaSessionsCountOne => '1 session';

  @override
  String agendaSessionsCountMany(int count) {
    return '$count sessions';
  }

  @override
  String get agendaBlockTime => 'Block time';

  @override
  String get agendaBlockNotImplemented => 'Time blocking not implemented yet.';

  @override
  String agendaFreeSlot(String start, String end) {
    return 'You have a free slot between $start and $end.';
  }

  @override
  String get agendaLoadingError => 'Error loading agenda';

  @override
  String get dowMon => 'MON';

  @override
  String get dowTue => 'TUE';

  @override
  String get dowWed => 'WED';

  @override
  String get dowThu => 'THU';

  @override
  String get dowFri => 'FRI';

  @override
  String get dowSat => 'SAT';

  @override
  String get dowSun => 'SUN';

  @override
  String get patientsTitle => 'Patients';

  @override
  String get patientsSearchHint => 'Search patient…';

  @override
  String get patientsFilterAll => 'All';

  @override
  String get patientsEmpty =>
      'No patients linked.\nShare your ID so they can sign up.';

  @override
  String get patientsEmptyFiltered => 'No patients match the filters.';

  @override
  String get patientsLoadingError => 'Error loading patients';

  @override
  String get patientsAdvancedFiltersSoon => 'Advanced filters coming soon.';

  @override
  String get patientsNextShort => 'Next';

  @override
  String patientAgeYears(int age) {
    return '$age years';
  }

  @override
  String get patientAgeUnknown => 'age —';

  @override
  String get patientsToday => 'today';

  @override
  String get patientsTomorrow => 'tomorrow';

  @override
  String get patientScreenTitle => 'Patient';

  @override
  String get patientChatTooltip => 'Messages';

  @override
  String patientInTreatment(String duration) {
    return 'In treatment · $duration';
  }

  @override
  String get patientEvolution8w => 'Progress · 8 weeks';

  @override
  String get patientMetricPhonemes => 'phonemes';

  @override
  String get patientMetricMobility => 'mobility';

  @override
  String get patientMetricEngagement => 'engagement';

  @override
  String get patientKpiSessions => 'sessions';

  @override
  String get patientKpiFrequency => 'frequency';

  @override
  String get patientKpiProgress => 'progress';

  @override
  String get patientStartSession => 'Start session';

  @override
  String patientStartSessionError(String error) {
    return 'Error starting session: $error';
  }

  @override
  String get durationLessThanMonth => 'less than 1 month';

  @override
  String get durationOneMonth => '1 month';

  @override
  String durationMonths(int n) {
    return '$n months';
  }

  @override
  String sessionTitleNumbered(String n) {
    return 'Session #$n';
  }

  @override
  String sessionStatusOngoing(String time) {
    return 'in progress · $time';
  }

  @override
  String sessionStatusScheduled(String time) {
    return 'scheduled · $time';
  }

  @override
  String get sessionSaveNotesTooltip => 'Save notes';

  @override
  String get sessionLivePill => 'live';

  @override
  String get sessionNotesTitle => 'Session notes';

  @override
  String get sessionNotesHint => 'Write notes about the session…';

  @override
  String sessionNotesEdited(String when) {
    return 'Edited $when';
  }

  @override
  String get sessionExercisesTitle => 'Assigned exercises';

  @override
  String get sessionExerciseBreathing => 'Diaphragmatic breathing';

  @override
  String get sessionExerciseBreathingSubtitle => '5x daily · 5 min';

  @override
  String get sessionExerciseReading => 'Reading aloud';

  @override
  String get sessionExerciseReadingSubtitle => 'daily · 10 min';

  @override
  String get sessionFinish => 'Finish session';

  @override
  String get sessionStart => 'Start session';

  @override
  String get sessionFinished => 'Session finished.';

  @override
  String get sessionNotesSaved => 'Notes saved.';

  @override
  String get relativeJustNow => 'just now';

  @override
  String relativeMinutes(int n) {
    return '$n min ago';
  }

  @override
  String relativeHours(int n) {
    return '${n}h ago';
  }

  @override
  String get taskNew => 'New therapy task';

  @override
  String get taskPatient => 'Patient';

  @override
  String get taskNoPatients =>
      'No patients available.\nPatients must sign up using your linking ID.';

  @override
  String get taskSelectPatient => 'Select a patient';

  @override
  String get taskTitleLabel => 'Task title';

  @override
  String get taskTitleRequired => 'Enter the title';

  @override
  String get taskDescription => 'Description';

  @override
  String get taskDescriptionRequired => 'Enter the description';

  @override
  String get taskDatetime => 'Scheduled date and time';

  @override
  String get taskInstructions => 'Instructions for the patient';

  @override
  String get taskLink => 'Link (optional)';

  @override
  String get taskSend => 'Send task';

  @override
  String get taskSendSuccess => 'Task sent successfully!';

  @override
  String taskSendError(String error) {
    return 'Error: $error';
  }

  @override
  String get taskLoadingError => 'Error loading patients';

  @override
  String get patientHi => 'Hi,';

  @override
  String get patientLoadingError => 'Error loading';

  @override
  String get patientNextSessionKicker => 'YOUR NEXT SESSION';

  @override
  String patientWithTherapist(String therapist, String specialty) {
    return 'with $therapist · $specialty';
  }

  @override
  String get patientYourTherapist => 'your therapist';

  @override
  String patientTodayAt(String time) {
    return 'Today, $time';
  }

  @override
  String get videoRoomSoon => 'Video room coming soon.';

  @override
  String get patientJoinRoom => 'Join room';

  @override
  String get patientNoSessionKicker => 'NO SESSIONS SCHEDULED';

  @override
  String get patientAllQuiet => 'All quiet for now.';

  @override
  String get patientLinkTherapist => 'Link to a therapist to get started.';

  @override
  String get patientTherapistWillSchedule =>
      'Your therapist will schedule the next session when available.';

  @override
  String get patientActivitiesForToday => 'Today\'s activities';

  @override
  String get patientNoActivities => 'No activities yet.';

  @override
  String get patientActivitiesLoadingError => 'Error loading activities';

  @override
  String get taskCompleted => 'completed';

  @override
  String get taskPending => 'pending';

  @override
  String get taskDefaultActivity => 'activity';

  @override
  String get tabCalendarTitle => 'Your calendar';

  @override
  String tabCalendarMsg(String therapist) {
    return 'Soon you\'ll see all your upcoming sessions scheduled with $therapist.';
  }

  @override
  String get placeholderYourTherapist => 'your therapist';

  @override
  String get placeholderDr => 'Dr.';

  @override
  String get evolutionTitle => 'Your progress';

  @override
  String get evolutionSubtitle => 'Track your treatment adherence.';

  @override
  String get evolutionAdherence => 'adherence';

  @override
  String get evolutionCompleted => 'completed';

  @override
  String get evolutionPending => 'pending';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileHelp => 'Help';

  @override
  String get profileSettings => 'Settings';

  @override
  String get chatOnline => 'online';

  @override
  String get chatNoMessages => 'Say hello!';

  @override
  String chatSendFailed(String error) {
    return 'Failed to send: $error';
  }

  @override
  String get chatLoadingError => 'Error loading messages';

  @override
  String chatTodaySeparator(String time) {
    return '— today, $time —';
  }

  @override
  String chatDateSeparator(String date) {
    return '— $date —';
  }

  @override
  String get chatInputHint => 'Write a message…';

  @override
  String get profileIncomplete => 'Incomplete profile';

  @override
  String get profileIncompleteBody =>
      'Your account exists in authentication, but the profile was not saved in the database. Sign out and create the account again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageDesc => 'Choose the app language';

  @override
  String get settingsLanguageAutoNote =>
      'Automatic: Brazil uses Portuguese, other countries use English.';

  @override
  String get languagePt => 'Portuguese (Brazil)';

  @override
  String get languageEn => 'English';

  @override
  String get languageEs => 'Spanish';

  @override
  String get settingsAppVersion => 'App version';
}

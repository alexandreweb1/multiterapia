// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Multiterapia';

  @override
  String get appTagline => 'cuidado conectado';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonError => 'Error';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonRetry => 'Intentar de nuevo';

  @override
  String get splashTagline => 'cuidado conectado';

  @override
  String get onboardingHowToEnter => '¿Cómo quieres entrar?';

  @override
  String get onboardingChooseProfile => 'Elige tu perfil de acceso';

  @override
  String get onboardingImTherapist => 'Soy terapeuta';

  @override
  String get onboardingTherapistSubtitle => 'Gestionar pacientes y sesiones';

  @override
  String get onboardingImPatient => 'Soy paciente';

  @override
  String get onboardingPatientSubtitle => 'Seguir mi proceso de cuidado';

  @override
  String get onboardingHaveAccount => 'Ya tengo cuenta — Iniciar sesión';

  @override
  String get loginWelcomeBack => 'Bienvenido(a)\nde nuevo.';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar tu cuidado.';

  @override
  String get loginEmail => 'Correo electrónico';

  @override
  String get loginEmailHint => 'tu@correo.com';

  @override
  String get loginEmailRequired => 'Ingresa tu correo';

  @override
  String get loginPassword => 'Contraseña';

  @override
  String get loginPasswordRequired => 'Ingresa tu contraseña';

  @override
  String get loginForgotPassword => 'Olvidé mi contraseña';

  @override
  String get loginForgotDialogBody =>
      'Pronto podrás recuperar la contraseña por correo electrónico.';

  @override
  String get loginSignIn => 'Iniciar sesión';

  @override
  String get loginOrContinue => 'o continúa con';

  @override
  String get loginNoAccountPrefix => '¿No tienes cuenta? ';

  @override
  String get loginSignUp => 'Regístrate';

  @override
  String get loginSocialNotImplemented =>
      'Inicio de sesión social aún no implementado.';

  @override
  String get errorUserNotFound => 'Usuario no encontrado.';

  @override
  String get errorWrongPassword => 'Correo o contraseña incorrectos.';

  @override
  String get errorInvalidEmail => 'Correo electrónico no válido.';

  @override
  String get errorTooManyRequests =>
      'Demasiados intentos. Inténtalo de nuevo en unos instantes.';

  @override
  String get errorNetwork => 'Sin conexión. Verifica tu internet.';

  @override
  String errorLoginGeneric(String message) {
    return 'Error al iniciar sesión: $message';
  }

  @override
  String get errorEmailInUse => 'Correo electrónico ya registrado.';

  @override
  String get errorWeakPassword => 'Contraseña débil (mínimo 6 caracteres).';

  @override
  String get errorInvalidTherapistId => 'ID del terapeuta no válido.';

  @override
  String get errorPermissionDenied =>
      'Permiso denegado por Firestore. Verifica las reglas (firestore.rules) publicadas en la consola.';

  @override
  String errorSignupGeneric(String message) {
    return 'Error al registrarse: $message';
  }

  @override
  String get registerCreateAccount => 'Crear cuenta';

  @override
  String get registerSubtitle => 'Comienza tu proceso en pocos pasos.';

  @override
  String get registerFullName => 'Nombre completo';

  @override
  String get registerFullNameHint => '¿Cómo quieres que te llamemos?';

  @override
  String get registerNameRequired => 'Ingresa tu nombre';

  @override
  String get registerEmailProfessional => 'Correo profesional';

  @override
  String get registerSpecialty => 'Especialidad';

  @override
  String get registerRegistry => 'Registro profesional';

  @override
  String get registerRegistryHint => 'N.º de matrícula 12345';

  @override
  String get registerRegistryRequired => 'Ingresa tu matrícula';

  @override
  String get registerAge => 'Edad';

  @override
  String get registerAgeHint => 'Ej.: 28';

  @override
  String get registerAgeRequired => 'Ingresa tu edad';

  @override
  String get registerTherapistId => 'ID del terapeuta';

  @override
  String get registerTherapistIdHint =>
      'Pega el ID proporcionado por tu terapeuta';

  @override
  String get registerTherapistIdRequired => 'Ingresa el ID del terapeuta';

  @override
  String get registerPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get registerPasswordWeak => 'Mínimo 6 caracteres';

  @override
  String get registerTermsPrefix => 'Acepto los ';

  @override
  String get registerTermsLink => 'términos de uso';

  @override
  String get registerTermsAnd => ' y la ';

  @override
  String get registerPrivacyLink => 'política de privacidad.';

  @override
  String get registerAcceptTerms =>
      'Acepta los términos de uso para continuar.';

  @override
  String get registerTherapist => 'Terapeuta';

  @override
  String get registerPatient => 'Paciente';

  @override
  String get registerCreateAccountButton => 'Crear cuenta';

  @override
  String get specialtyFonoLabel => 'Fonoaudiología';

  @override
  String get specialtyFisioLabel => 'Fisioterapia';

  @override
  String get specialtyPsicoLabel => 'Psicología';

  @override
  String get specialtyNoneLabel => '—';

  @override
  String get specialtyFonoShort => 'Fono';

  @override
  String get specialtyFisioShort => 'Fisio';

  @override
  String get specialtyPsicoShort => 'Psico';

  @override
  String get specialtyNoneShort => '—';

  @override
  String get greetingMorning => 'Buenos días,';

  @override
  String get greetingAfternoon => 'Buenas tardes,';

  @override
  String get greetingEvening => 'Buenas noches,';

  @override
  String get today => 'Hoy';

  @override
  String get statSessions => 'sesiones';

  @override
  String get statPatients => 'pacientes';

  @override
  String get statScheduled => 'previstas';

  @override
  String get nextSessions => 'Próximas sesiones';

  @override
  String get seeWeek => 'Ver semana →';

  @override
  String get noSessionsToday => 'Sin sesiones agendadas para hoy';

  @override
  String get errorLoadingSessions => 'Error al cargar las sesiones';

  @override
  String get errorLoadingProfile => 'Error al cargar el perfil';

  @override
  String get copyLinkId => 'Copiar mi ID de vinculación';

  @override
  String get copyLinkIdSubtitle =>
      'Compártelo con tus pacientes para que se registren';

  @override
  String get idCopied => '¡ID copiado!';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get noNotifications => 'Sin notificaciones por ahora.';

  @override
  String get sessionStatusInProgress => 'En curso';

  @override
  String get sessionStatusLate => 'Atrasada';

  @override
  String get sessionStatusConfirmed => 'Confirmada';

  @override
  String sessionInHours(int hours) {
    return 'en ${hours}h';
  }

  @override
  String sessionInMinutes(int minutes) {
    return 'en ${minutes}min';
  }

  @override
  String agendaWeek(int week) {
    return 'semana $week';
  }

  @override
  String get agendaNoSessionsDay => 'Sin sesiones este día.';

  @override
  String get agendaSessionsCountZero => 'sin sesiones';

  @override
  String get agendaSessionsCountOne => '1 sesión';

  @override
  String agendaSessionsCountMany(int count) {
    return '$count sesiones';
  }

  @override
  String get agendaBlockTime => 'Bloquear horario';

  @override
  String get agendaBlockNotImplemented =>
      'Bloqueo de horario aún no implementado.';

  @override
  String agendaFreeSlot(String start, String end) {
    return 'Tienes un hueco libre entre $start y $end.';
  }

  @override
  String get agendaLoadingError => 'Error al cargar la agenda';

  @override
  String get dowMon => 'LUN';

  @override
  String get dowTue => 'MAR';

  @override
  String get dowWed => 'MIÉ';

  @override
  String get dowThu => 'JUE';

  @override
  String get dowFri => 'VIE';

  @override
  String get dowSat => 'SÁB';

  @override
  String get dowSun => 'DOM';

  @override
  String get patientsTitle => 'Pacientes';

  @override
  String get patientsSearchHint => 'Buscar paciente…';

  @override
  String get patientsFilterAll => 'Todos';

  @override
  String get patientsEmpty =>
      'No hay pacientes vinculados.\nComparte tu ID para que se registren.';

  @override
  String get patientsEmptyFiltered =>
      'Ningún paciente coincide con los filtros.';

  @override
  String get patientsLoadingError => 'Error al cargar pacientes';

  @override
  String get patientsAdvancedFiltersSoon => 'Filtros avanzados próximamente.';

  @override
  String get patientsNextShort => 'Próx.';

  @override
  String patientAgeYears(int age) {
    return '$age años';
  }

  @override
  String get patientAgeUnknown => 'edad —';

  @override
  String get patientsToday => 'hoy';

  @override
  String get patientsTomorrow => 'mañana';

  @override
  String get patientScreenTitle => 'Paciente';

  @override
  String get patientChatTooltip => 'Mensajes';

  @override
  String patientInTreatment(String duration) {
    return 'En tratamiento · $duration';
  }

  @override
  String get patientEvolution8w => 'Evolución · 8 semanas';

  @override
  String get patientMetricPhonemes => 'fonemas';

  @override
  String get patientMetricMobility => 'movilidad';

  @override
  String get patientMetricEngagement => 'compromiso';

  @override
  String get patientKpiSessions => 'sesiones';

  @override
  String get patientKpiFrequency => 'frecuencia';

  @override
  String get patientKpiProgress => 'progreso';

  @override
  String get patientStartSession => 'Iniciar sesión';

  @override
  String patientStartSessionError(String error) {
    return 'Error al iniciar la sesión: $error';
  }

  @override
  String get durationLessThanMonth => 'menos de 1 mes';

  @override
  String get durationOneMonth => '1 mes';

  @override
  String durationMonths(int n) {
    return '$n meses';
  }

  @override
  String sessionTitleNumbered(String n) {
    return 'Sesión n.º $n';
  }

  @override
  String sessionStatusOngoing(String time) {
    return 'en curso · $time';
  }

  @override
  String sessionStatusScheduled(String time) {
    return 'agendada · $time';
  }

  @override
  String get sessionSaveNotesTooltip => 'Guardar notas';

  @override
  String get sessionLivePill => 'en vivo';

  @override
  String get sessionNotesTitle => 'Notas de la sesión';

  @override
  String get sessionNotesHint => 'Escribe observaciones sobre la sesión…';

  @override
  String sessionNotesEdited(String when) {
    return 'Editado $when';
  }

  @override
  String get sessionExercisesTitle => 'Ejercicios asignados';

  @override
  String get sessionExerciseBreathing => 'Respiración diafragmática';

  @override
  String get sessionExerciseBreathingSubtitle => '5 veces al día · 5 min';

  @override
  String get sessionExerciseReading => 'Lectura en voz alta';

  @override
  String get sessionExerciseReadingSubtitle => 'diario · 10 min';

  @override
  String get sessionFinish => 'Finalizar sesión';

  @override
  String get sessionStart => 'Iniciar sesión';

  @override
  String get sessionFinished => 'Sesión finalizada.';

  @override
  String get sessionNotesSaved => 'Notas guardadas.';

  @override
  String get relativeJustNow => 'hace instantes';

  @override
  String relativeMinutes(int n) {
    return 'hace $n min';
  }

  @override
  String relativeHours(int n) {
    return 'hace ${n}h';
  }

  @override
  String get taskNew => 'Nueva terapia';

  @override
  String get taskPatient => 'Paciente';

  @override
  String get taskNoPatients =>
      'No hay pacientes disponibles.\nLos pacientes deben registrarse usando tu ID de vinculación.';

  @override
  String get taskSelectPatient => 'Selecciona un paciente';

  @override
  String get taskTitleLabel => 'Título de la terapia';

  @override
  String get taskTitleRequired => 'Ingresa el título';

  @override
  String get taskDescription => 'Descripción';

  @override
  String get taskDescriptionRequired => 'Ingresa la descripción';

  @override
  String get taskDatetime => 'Fecha y hora programadas';

  @override
  String get taskInstructions => 'Instrucciones para el paciente';

  @override
  String get taskLink => 'Enlace (opcional)';

  @override
  String get taskSend => 'Enviar terapia';

  @override
  String get taskSendSuccess => '¡Terapia enviada con éxito!';

  @override
  String taskSendError(String error) {
    return 'Error: $error';
  }

  @override
  String get taskLoadingError => 'Error al cargar pacientes';

  @override
  String get patientHi => 'Hola,';

  @override
  String get patientLoadingError => 'Error al cargar';

  @override
  String get patientNextSessionKicker => 'TU PRÓXIMA SESIÓN';

  @override
  String patientWithTherapist(String therapist, String specialty) {
    return 'con $therapist · $specialty';
  }

  @override
  String get patientYourTherapist => 'tu terapeuta';

  @override
  String patientTodayAt(String time) {
    return 'Hoy, $time';
  }

  @override
  String get videoRoomSoon => 'Sala de vídeo próximamente.';

  @override
  String get patientJoinRoom => 'Entrar en la sala';

  @override
  String get patientNoSessionKicker => 'SIN SESIONES AGENDADAS';

  @override
  String get patientAllQuiet => 'Todo tranquilo por aquí.';

  @override
  String get patientLinkTherapist => 'Vincúlate a un terapeuta para empezar.';

  @override
  String get patientTherapistWillSchedule =>
      'Tu terapeuta agendará la próxima cuando esté disponible.';

  @override
  String get patientActivitiesForToday => 'Actividades para hoy';

  @override
  String get patientNoActivities => 'Aún no hay actividades.';

  @override
  String get patientActivitiesLoadingError => 'Error al cargar actividades';

  @override
  String get taskCompleted => 'completado';

  @override
  String get taskPending => 'pendiente';

  @override
  String get taskDefaultActivity => 'actividad';

  @override
  String get tabCalendarTitle => 'Tu agenda';

  @override
  String tabCalendarMsg(String therapist) {
    return 'Pronto verás aquí todas tus próximas sesiones agendadas con $therapist.';
  }

  @override
  String get placeholderYourTherapist => 'tu terapeuta';

  @override
  String get placeholderDr => 'Dr./Dra.';

  @override
  String get evolutionTitle => 'Tu evolución';

  @override
  String get evolutionSubtitle => 'Sigue tu adherencia al tratamiento.';

  @override
  String get evolutionAdherence => 'de adherencia';

  @override
  String get evolutionCompleted => 'completadas';

  @override
  String get evolutionPending => 'pendientes';

  @override
  String get profilePrivacy => 'Privacidad';

  @override
  String get profileHelp => 'Ayuda';

  @override
  String get profileSettings => 'Configuración';

  @override
  String get chatOnline => 'en línea';

  @override
  String get chatNoMessages => '¡Saluda!';

  @override
  String chatSendFailed(String error) {
    return 'Error al enviar: $error';
  }

  @override
  String get chatLoadingError => 'Error al cargar los mensajes';

  @override
  String chatTodaySeparator(String time) {
    return '— hoy, $time —';
  }

  @override
  String chatDateSeparator(String date) {
    return '— $date —';
  }

  @override
  String get chatInputHint => 'Escribe un mensaje…';

  @override
  String get profileIncomplete => 'Registro incompleto';

  @override
  String get profileIncompleteBody =>
      'Tu cuenta existe en la autenticación, pero el perfil no se guardó en la base de datos. Cierra sesión y vuelve a crear el registro.';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDesc => 'Elige el idioma de la aplicación';

  @override
  String get settingsLanguageAutoNote =>
      'Automático: Brasil usa portugués; otros países, inglés.';

  @override
  String get languagePt => 'Portugués (Brasil)';

  @override
  String get languageEn => 'Inglés';

  @override
  String get languageEs => 'Español';

  @override
  String get settingsAppVersion => 'Versión de la app';
}

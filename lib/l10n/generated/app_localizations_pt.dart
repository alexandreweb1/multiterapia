// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Multiterapia';

  @override
  String get appTagline => 'cuidado conectado';

  @override
  String get commonLoading => 'Carregando…';

  @override
  String get commonError => 'Erro';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get splashTagline => 'cuidado conectado';

  @override
  String get onboardingHowToEnter => 'Como você quer entrar?';

  @override
  String get onboardingChooseProfile => 'Escolha seu perfil de acesso';

  @override
  String get onboardingImTherapist => 'Sou terapeuta';

  @override
  String get onboardingTherapistSubtitle => 'Gerenciar pacientes e sessões';

  @override
  String get onboardingImPatient => 'Sou paciente';

  @override
  String get onboardingPatientSubtitle => 'Acompanhar minha jornada';

  @override
  String get onboardingHaveAccount => 'Já tenho conta — Entrar';

  @override
  String get loginWelcomeBack => 'Bem-vindo(a)\nde volta.';

  @override
  String get loginSubtitle => 'Entre para continuar seu cuidado.';

  @override
  String get loginEmail => 'E-mail';

  @override
  String get loginEmailHint => 'seu@email.com';

  @override
  String get loginEmailRequired => 'Informe o e-mail';

  @override
  String get loginPassword => 'Senha';

  @override
  String get loginPasswordRequired => 'Informe a senha';

  @override
  String get loginForgotPassword => 'Esqueci minha senha';

  @override
  String get loginForgotDialogBody =>
      'Em breve será possível recuperar a senha por e-mail.';

  @override
  String get loginSignIn => 'Entrar';

  @override
  String get loginOrContinue => 'ou continue com';

  @override
  String get loginNoAccountPrefix => 'Não tem conta? ';

  @override
  String get loginSignUp => 'Cadastre-se';

  @override
  String get loginSocialNotImplemented =>
      'Login social ainda não implementado.';

  @override
  String get errorUserNotFound => 'Usuário não encontrado.';

  @override
  String get errorWrongPassword => 'E-mail ou senha incorretos.';

  @override
  String get errorInvalidEmail => 'E-mail inválido.';

  @override
  String get errorTooManyRequests =>
      'Muitas tentativas. Tente novamente em instantes.';

  @override
  String get errorNetwork => 'Sem conexão. Verifique sua internet.';

  @override
  String errorLoginGeneric(String message) {
    return 'Erro ao fazer login: $message';
  }

  @override
  String get errorEmailInUse => 'E-mail já cadastrado.';

  @override
  String get errorWeakPassword => 'Senha fraca (mínimo 6 caracteres).';

  @override
  String get errorInvalidTherapistId => 'ID do terapeuta inválido.';

  @override
  String get errorPermissionDenied =>
      'Permissão negada pelo Firestore. Verifique as regras (firestore.rules) publicadas no console.';

  @override
  String errorSignupGeneric(String message) {
    return 'Erro ao cadastrar: $message';
  }

  @override
  String get registerCreateAccount => 'Criar conta';

  @override
  String get registerSubtitle => 'Comece sua jornada em poucos passos.';

  @override
  String get registerFullName => 'Nome completo';

  @override
  String get registerFullNameHint => 'Como você quer ser chamado(a)';

  @override
  String get registerNameRequired => 'Informe seu nome';

  @override
  String get registerEmailProfessional => 'E-mail profissional';

  @override
  String get registerSpecialty => 'Especialidade';

  @override
  String get registerRegistry => 'Registro profissional';

  @override
  String get registerRegistryHint => 'CRFa 5/12345';

  @override
  String get registerRegistryRequired => 'Informe seu registro';

  @override
  String get registerAge => 'Idade';

  @override
  String get registerAgeHint => 'Ex: 28';

  @override
  String get registerAgeRequired => 'Informe a idade';

  @override
  String get registerTherapistId => 'ID do terapeuta';

  @override
  String get registerTherapistIdHint =>
      'Cole o ID fornecido pelo seu terapeuta';

  @override
  String get registerTherapistIdRequired => 'Informe o ID do terapeuta';

  @override
  String get registerPasswordHint => 'Mínimo 6 caracteres';

  @override
  String get registerPasswordWeak => 'Mínimo 6 caracteres';

  @override
  String get registerTermsPrefix => 'Concordo com os ';

  @override
  String get registerTermsLink => 'termos de uso';

  @override
  String get registerTermsAnd => ' e a ';

  @override
  String get registerPrivacyLink => 'política de privacidade.';

  @override
  String get registerAcceptTerms => 'Aceite os termos de uso para continuar.';

  @override
  String get registerTherapist => 'Terapeuta';

  @override
  String get registerPatient => 'Paciente';

  @override
  String get registerCreateAccountButton => 'Criar conta';

  @override
  String get specialtyFonoLabel => 'Fonoaudiologia';

  @override
  String get specialtyFisioLabel => 'Fisioterapia';

  @override
  String get specialtyPsicoLabel => 'Psicologia';

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
  String get greetingMorning => 'Bom dia,';

  @override
  String get greetingAfternoon => 'Boa tarde,';

  @override
  String get greetingEvening => 'Boa noite,';

  @override
  String get today => 'Hoje';

  @override
  String get statSessions => 'sessões';

  @override
  String get statPatients => 'pacientes';

  @override
  String get statScheduled => 'previstas';

  @override
  String get nextSessions => 'Próximas sessões';

  @override
  String get seeWeek => 'Ver semana →';

  @override
  String get noSessionsToday => 'Sem sessões agendadas para hoje';

  @override
  String get errorLoadingSessions => 'Erro ao carregar sessões';

  @override
  String get errorLoadingProfile => 'Erro ao carregar perfil';

  @override
  String get copyLinkId => 'Copiar meu ID de vinculação';

  @override
  String get copyLinkIdSubtitle =>
      'Compartilhe com seus pacientes para que eles se cadastrem';

  @override
  String get idCopied => 'ID copiado!';

  @override
  String get signOut => 'Sair';

  @override
  String get noNotifications => 'Sem notificações por enquanto.';

  @override
  String get sessionStatusInProgress => 'Em andamento';

  @override
  String get sessionStatusLate => 'Atrasada';

  @override
  String get sessionStatusConfirmed => 'Confirmada';

  @override
  String sessionInHours(int hours) {
    return 'em ${hours}h';
  }

  @override
  String sessionInMinutes(int minutes) {
    return 'em ${minutes}min';
  }

  @override
  String agendaWeek(int week) {
    return 'semana $week';
  }

  @override
  String get agendaNoSessionsDay => 'Sem sessões neste dia.';

  @override
  String get agendaSessionsCountZero => 'sem sessões';

  @override
  String get agendaSessionsCountOne => '1 sessão';

  @override
  String agendaSessionsCountMany(int count) {
    return '$count sessões';
  }

  @override
  String get agendaBlockTime => 'Bloquear horário';

  @override
  String get agendaBlockNotImplemented =>
      'Bloqueio de horário ainda não implementado.';

  @override
  String agendaFreeSlot(String start, String end) {
    return 'Você tem horário livre entre $start e $end.';
  }

  @override
  String get agendaLoadingError => 'Erro ao carregar agenda';

  @override
  String get dowMon => 'SEG';

  @override
  String get dowTue => 'TER';

  @override
  String get dowWed => 'QUA';

  @override
  String get dowThu => 'QUI';

  @override
  String get dowFri => 'SEX';

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
      'Nenhum paciente vinculado.\nCompartilhe seu ID para que eles se cadastrem.';

  @override
  String get patientsEmptyFiltered =>
      'Nenhum paciente corresponde aos filtros.';

  @override
  String get patientsLoadingError => 'Erro ao carregar pacientes';

  @override
  String get patientsAdvancedFiltersSoon => 'Filtros avançados em breve.';

  @override
  String get patientsNextShort => 'Próx.';

  @override
  String patientAgeYears(int age) {
    return '$age anos';
  }

  @override
  String get patientAgeUnknown => 'idade —';

  @override
  String get patientsToday => 'hoje';

  @override
  String get patientsTomorrow => 'amanhã';

  @override
  String get patientScreenTitle => 'Paciente';

  @override
  String get patientChatTooltip => 'Mensagens';

  @override
  String patientInTreatment(String duration) {
    return 'Em tratamento · $duration';
  }

  @override
  String get patientEvolution8w => 'Evolução · 8 semanas';

  @override
  String get patientMetricPhonemes => 'fonemas';

  @override
  String get patientMetricMobility => 'mobilidade';

  @override
  String get patientMetricEngagement => 'engajamento';

  @override
  String get patientKpiSessions => 'sessões';

  @override
  String get patientKpiFrequency => 'frequência';

  @override
  String get patientKpiProgress => 'progresso';

  @override
  String get patientStartSession => 'Iniciar sessão';

  @override
  String patientStartSessionError(String error) {
    return 'Erro ao iniciar sessão: $error';
  }

  @override
  String get durationLessThanMonth => 'menos de 1 mês';

  @override
  String get durationOneMonth => '1 mês';

  @override
  String durationMonths(int n) {
    return '$n meses';
  }

  @override
  String sessionTitleNumbered(String n) {
    return 'Sessão #$n';
  }

  @override
  String sessionStatusOngoing(String time) {
    return 'em andamento · $time';
  }

  @override
  String sessionStatusScheduled(String time) {
    return 'agendada · $time';
  }

  @override
  String get sessionSaveNotesTooltip => 'Salvar notas';

  @override
  String get sessionLivePill => 'ao vivo';

  @override
  String get sessionNotesTitle => 'Anotações da sessão';

  @override
  String get sessionNotesHint => 'Escreva observações sobre a sessão…';

  @override
  String sessionNotesEdited(String when) {
    return 'Editado $when';
  }

  @override
  String get sessionExercisesTitle => 'Exercícios atribuídos';

  @override
  String get sessionExerciseBreathing => 'Respiração diafragmática';

  @override
  String get sessionExerciseBreathingSubtitle => '5x ao dia · 5 min';

  @override
  String get sessionExerciseReading => 'Leitura em voz alta';

  @override
  String get sessionExerciseReadingSubtitle => 'diário · 10 min';

  @override
  String get sessionFinish => 'Finalizar sessão';

  @override
  String get sessionStart => 'Iniciar sessão';

  @override
  String get sessionFinished => 'Sessão finalizada.';

  @override
  String get sessionNotesSaved => 'Notas salvas.';

  @override
  String get relativeJustNow => 'há instantes';

  @override
  String relativeMinutes(int n) {
    return 'há $n min';
  }

  @override
  String relativeHours(int n) {
    return 'há ${n}h';
  }

  @override
  String get taskNew => 'Nova Terapia';

  @override
  String get taskPatient => 'Paciente';

  @override
  String get taskNoPatients =>
      'Nenhum paciente disponível.\nPacientes devem se cadastrar usando seu ID de vinculação.';

  @override
  String get taskSelectPatient => 'Selecione um paciente';

  @override
  String get taskTitleLabel => 'Título da Terapia';

  @override
  String get taskTitleRequired => 'Informe o título';

  @override
  String get taskDescription => 'Descrição';

  @override
  String get taskDescriptionRequired => 'Informe a descrição';

  @override
  String get taskDatetime => 'Data e Hora agendada';

  @override
  String get taskInstructions => 'Instruções para o paciente';

  @override
  String get taskLink => 'Link (opcional)';

  @override
  String get taskSend => 'Enviar Terapia';

  @override
  String get taskSendSuccess => 'Terapia enviada com sucesso!';

  @override
  String taskSendError(String error) {
    return 'Erro: $error';
  }

  @override
  String get taskLoadingError => 'Erro ao carregar pacientes';

  @override
  String get patientHi => 'Olá,';

  @override
  String get patientLoadingError => 'Erro ao carregar';

  @override
  String get patientNextSessionKicker => 'SUA PRÓXIMA SESSÃO';

  @override
  String patientWithTherapist(String therapist, String specialty) {
    return 'com $therapist · $specialty';
  }

  @override
  String get patientYourTherapist => 'seu terapeuta';

  @override
  String patientTodayAt(String time) {
    return 'Hoje, $time';
  }

  @override
  String get videoRoomSoon => 'Sala de vídeo em breve.';

  @override
  String get patientJoinRoom => 'Entrar na sala';

  @override
  String get patientNoSessionKicker => 'NENHUMA SESSÃO AGENDADA';

  @override
  String get patientAllQuiet => 'Tudo tranquilo por aqui.';

  @override
  String get patientLinkTherapist => 'Vincule-se a um terapeuta para começar.';

  @override
  String get patientTherapistWillSchedule =>
      'Seu terapeuta agendará a próxima quando estiver disponível.';

  @override
  String get patientActivitiesForToday => 'Atividades para hoje';

  @override
  String get patientNoActivities => 'Nenhuma atividade ainda.';

  @override
  String get patientActivitiesLoadingError => 'Erro ao carregar atividades';

  @override
  String get taskCompleted => 'concluído';

  @override
  String get taskPending => 'pendente';

  @override
  String get taskDefaultActivity => 'atividade';

  @override
  String get tabCalendarTitle => 'Sua agenda';

  @override
  String tabCalendarMsg(String therapist) {
    return 'Em breve, você verá aqui todas as suas próximas sessões agendadas com $therapist.';
  }

  @override
  String get placeholderYourTherapist => 'seu terapeuta';

  @override
  String get placeholderDr => 'Dra./Dr.';

  @override
  String get evolutionTitle => 'Sua evolução';

  @override
  String get evolutionSubtitle => 'Acompanhe sua adesão ao tratamento.';

  @override
  String get evolutionAdherence => 'de adesão';

  @override
  String get evolutionCompleted => 'concluídas';

  @override
  String get evolutionPending => 'pendentes';

  @override
  String get profilePrivacy => 'Privacidade';

  @override
  String get profileHelp => 'Ajuda';

  @override
  String get profileSettings => 'Configurações';

  @override
  String get chatOnline => 'online';

  @override
  String get chatNoMessages => 'Diga olá!';

  @override
  String chatSendFailed(String error) {
    return 'Falha ao enviar: $error';
  }

  @override
  String get chatLoadingError => 'Erro ao carregar mensagens';

  @override
  String chatTodaySeparator(String time) {
    return '— hoje, $time —';
  }

  @override
  String chatDateSeparator(String date) {
    return '— $date —';
  }

  @override
  String get chatInputHint => 'Escreva uma mensagem…';

  @override
  String get profileIncomplete => 'Cadastro incompleto';

  @override
  String get profileIncompleteBody =>
      'Sua conta existe na autenticação, mas o perfil não foi gravado no banco. Saia e crie o cadastro novamente.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDesc => 'Escolha o idioma do aplicativo';

  @override
  String get settingsLanguageAutoNote =>
      'Automático: Brasil usa Português, outros países usam Inglês.';

  @override
  String get languagePt => 'Português (Brasil)';

  @override
  String get languageEn => 'Inglês';

  @override
  String get languageEs => 'Espanhol';

  @override
  String get settingsAppVersion => 'Versão do aplicativo';
}

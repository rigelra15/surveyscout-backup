class AppRoutes {
  // Authentication routes
  static const welcome = '/';
  static const login = '/login';
  static const clientSignup = '/clientSignup';
  static const surveyorSignup = '/surveyorSignup';
  static const respondenSignup = '/respondenSignup';

  // Client routes
  static const clientProjectList = '/clientProjectList';
  static const chooseRecruitment = '/chooseRecruitment';
  static const clientChat = '/clientChat';
  static const clientProjectsDetail = '/clientProjectsDetail';

  // Surveyor routes
  static const surveyorProjects = '/surveyorProjects';
  static const surveyorProjectDetails = '/surveyorProjectDetails';

  // Respondent routes
  static const respondenProjects = '/respondenProjects';

  // Payment and transaction routes
  static const paymentGateway = '/paymentGateway';
  static const paymentConfirmation = '/paymentConfirmation';
  static const paymentConfirmationFailed = '/paymentConfirmationFailed';
  static const paymentConfirmationTimeout = '/paymentConfirmationTimeout';
  static const transactionReview = '/transactionReview';
  static const transactionReviewRespondent = '/transactionReviewRespondent';

  // Respondent-specific details
  static const respondentSurveyDetails = '/respondentSurveyDetails';
  static const respondentCriteriaDetails = '/respondentCriteriaDetails';

  // Client Project Details (from root-level pages)
  static const clientRespondenProyekDetailMerekrut = '/clientRespondenProyekDetailMerekrut';
  static const clientSurveyorProyekDetailButuhTinjau = '/clientSurveyorProyekDetailButuhTinjau';
  static const clientSurveyorProyekDetailDikerjakan = '/clientSurveyorProyekDetailDikerjakan';
  static const clientSurveyorProyekDetailDMenungguBayar = '/clientSurveyorProyekDetailDMenungguBayar';
  static const clientSurveyorProyekDetailDraft = '/clientSurveyorProyekDetailDraft';
  static const clientSurveyorProyekDetailKadaluarsa = '/clientSurveyorProyekDetailKadaluarsa';
  static const clientSurveyorProyekDetailPeringatan = '/clientSurveyorProyekDetailPeringatan';
  static const clientSurveyorProyekDetailSelesai = '/clientSurveyorProyekDetailSelesai';
}

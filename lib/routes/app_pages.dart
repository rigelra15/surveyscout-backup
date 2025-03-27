import 'package:get/get.dart';

// Authentication pages
import 'package:surveyscout/pages/login.dart';
import 'package:surveyscout/pages/client/clientsignup.dart';
import 'package:surveyscout/pages/surveyor/surveyorsignup.dart';
import 'package:surveyscout/pages/responden/respondensignup.dart';

// Root-level pages
import 'package:surveyscout/pages/welcome.dart';

// Client pages
import 'package:surveyscout/pages/client/choose_recruitment_screen.dart';
import 'package:surveyscout/pages/client/clientchat.dart';
import 'package:surveyscout/pages/client/clientprojects.dart';
import 'package:surveyscout/pages/client/clientprojectsdetail.dart';
import 'package:surveyscout/pages/client/payment_confirmation_failed.dart';
import 'package:surveyscout/pages/client/payment_confirmation_screen.dart';
import 'package:surveyscout/pages/client/payment_confirmation_timeout.dart';
import 'package:surveyscout/pages/client/payment_gateway_screen.dart';
import 'package:surveyscout/pages/client/respondent_criteria_screen.dart';
import 'package:surveyscout/pages/client/respondent_survey_details.dart';
import 'package:surveyscout/pages/client/respondent_survey_details_screen.dart';
import 'package:surveyscout/pages/client/surveyor_project_details_screen.dart';
import 'package:surveyscout/pages/client/transaction_review_respondent_screen.dart';
import 'package:surveyscout/pages/client/transaction_review_screen.dart';

// Surveyor pages
import 'package:surveyscout/pages/surveyor/surveyorakun.dart';
import 'package:surveyscout/pages/surveyor/surveyorchat.dart';
import 'package:surveyscout/pages/surveyor/surveyormyprojects.dart';
import 'package:surveyscout/pages/surveyor/surveyorprojects.dart';

// Respondent pages
import 'package:surveyscout/pages/responden/respondenaccount.dart';
import 'package:surveyscout/pages/responden/respondenchat.dart';
import 'package:surveyscout/pages/responden/respondenmyprojects.dart';
import 'package:surveyscout/pages/responden/respondenprojects.dart';

// Root-level additional pages
import 'package:surveyscout/pages/clientrespondenproyekdetailmerekrut.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetailbutuhtinjau.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetaildikerjakan.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetaildmenunggubayar.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetaildraft.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetailkadaluwarsa.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetailperingatan.dart';
import 'package:surveyscout/pages/clientsurveyorproyekdetailselesai.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    // Welcome page
    GetPage(name: AppRoutes.welcome, page: () => Welcome()),

    // Authentication routes
    GetPage(name: AppRoutes.login, page: () => Login()),
    GetPage(name: AppRoutes.clientSignup, page: () => ClientSignUp()),  // Make sure this page exists
    GetPage(name: AppRoutes.surveyorSignup, page: () => SurveyorSignUp()), // Make sure this page exists
    GetPage(name: AppRoutes.respondenSignup, page: () => RespondenSignUp()), // Make sure this page exists

    // Client routes
    GetPage(name: AppRoutes.clientProjectList, page: () => ClientProjects()),
    GetPage(name: AppRoutes.chooseRecruitment, page: () => ChooseRecruitmentScreen()),
    GetPage(name: AppRoutes.clientChat, page: () => ClientChat()),
    // GetPage(name: AppRoutes.clientProjectsDetail, page: () => ClientProjectsDetail(id: id, type: type)),  // Assuming this exists

    // Surveyor routes
    GetPage(name: AppRoutes.surveyorProjects, page: () => SurveyorProjects()),
    GetPage(name: AppRoutes.surveyorProjectDetails, page: () => SurveyorProjectDetailsScreen()),

    // Respondent routes
    GetPage(name: AppRoutes.respondenProjects, page: () => RespondenProjects()),

    // Payment routes
    // GetPage(name: AppRoutes.paymentGateway, page: () => PaymentGatewayScreen(snapUrl: snapUrl, orderId: orderId, idDraft: idDraft)),
    GetPage(name: AppRoutes.paymentConfirmation, page: () => PaymentConfirmationScreen()),
    GetPage(name: AppRoutes.paymentConfirmationFailed, page: () => PaymentFailedScreen()),
    GetPage(name: AppRoutes.paymentConfirmationTimeout, page: () => PaymentTimeoutScreen()),

    // Transaction routes
    // GetPage(name: AppRoutes.transactionReview, page: () => TransactionReviewScreen(idDraft: idDraft, commission: commission)),
    GetPage(name: AppRoutes.transactionReviewRespondent, page: () => TransactionReviewRespondentScreen()),

    // Respondent-specific details
    // GetPage(name: AppRoutes.respondentSurveyDetails, page: () => RespondentSurveyDetailsScreen()),
    GetPage(name: AppRoutes.respondentCriteriaDetails, page: () => RespondentCriteriaDetailsScreen()),

    // Client Project Details (root-level pages)
    // GetPage(name: AppRoutes.clientRespondenProyekDetailMerekrut, page: () => Clientrespondenproyekdetailmerekrut(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailButuhTinjau, page: () => Clientsurveyorproyekdetailbutuhtinjau(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDikerjakan, page: () => Clientsurveyorproyekdetaildikerjakan(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDMenungguBayar, page: () => Clientsurveyorproyekdetailmenunggubayar(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDraft, page: () => Clientsurveyorproyekdetaildraft(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailKadaluarsa, page: () => Clientsurveyorproyekdetailkadaluwarsa(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailPeringatan, page: () => Clientsurveyorproyekdetailperingatan(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailSelesai, page: () => Clientsurveyorproyekdetailselesai(id: id, type: type)),

    // Respondent routes
    GetPage(name: AppRoutes.respondenProjects, page: () => RespondenProjects()),

    // Payment routes
    // GetPage(name: AppRoutes.paymentGateway, page: () => PaymentGatewayScreen(snapUrl: snapUrl, orderId: orderId, idDraft: idDraft)),
    GetPage(name: AppRoutes.paymentConfirmation, page: () => PaymentConfirmationScreen()),
    GetPage(name: AppRoutes.paymentConfirmationFailed, page: () => PaymentFailedScreen()),
    GetPage(name: AppRoutes.paymentConfirmationTimeout, page: () => PaymentTimeoutScreen()),

    // Transaction routes
    // GetPage(name: AppRoutes.transactionReview, page: () => TransactionReviewScreen(idDraft: idDraft, commission: commission)),
    // GetPage(name: AppRoutes.transactionReviewRespondent, page: () => TransactionReviewRespondentScreen()),

    // Respondent-specific details
    // GetPage(name: AppRoutes.respondentSurveyDetails, page: () => RespondentSurveyDetailsScreen()),
    GetPage(name: AppRoutes.respondentCriteriaDetails, page: () => RespondentCriteriaDetailsScreen()),

    // Client Project Details (root-level pages)
    // GetPage(name: AppRoutes.clientRespondenProyekDetailMerekrut, page: () => Clientrespondenproyekdetailmerekrut(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailButuhTinjau, page: () => Clientsurveyorproyekdetailbutuhtinjau(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDikerjakan, page: () => Clientsurveyorproyekdetaildikerjakan(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDMenungguBayar, page: () => Clientsurveyorproyekdetailmenunggubayar(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailDraft, page: () => Clientsurveyorproyekdetaildraft(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailKadaluarsa, page: () => Clientsurveyorproyekdetailkadaluwarsa(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailPeringatan, page: () => Clientsurveyorproyekdetailperingatan(id: id, type: type)),
    // GetPage(name: AppRoutes.clientSurveyorProyekDetailSelesai, page: () => Clientsurveyorproyekdetailselesai(id: id, type: type)),
  ];
}


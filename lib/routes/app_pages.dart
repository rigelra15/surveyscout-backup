// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:surveyscout/pages/client/transaction_review_respondent_screen.dart';
import '../pages/welcome.dart';
import '../pages/surveyor/surveyorprojects.dart';
import '../pages/client/clientprojects.dart';
import '../pages/client/choose_recruitment_screen.dart';
import '../pages/client/payment_confirmation_failed.dart'; // Ensure this exists
import '../pages/client/payment_gateway_screen.dart';
import '../pages/client/respondent_criteria_screen.dart';
import '../pages/client/respondent_survey_details_screen.dart';
import '../pages/client/surveyor_project_details_screen.dart';
import '../pages/client/transaction_review_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.welcome, page: () => Welcome()),
    GetPage(name: AppRoutes.clientProjectList, page: () => SecondPage()),
    GetPage(name: AppRoutes.chooseRecruitment, page: () => ChooseRecruitmentScreen()),
    GetPage(name: AppRoutes.surveyorProjectDetails, page: () => SurveyorProjectDetailsScreen()),
    GetPage(name: AppRoutes.respondentSurveyDetails, page: () => RespondentSurveyDetailsScreen()),
    GetPage(name: AppRoutes.respondentCriteriaDetails, page: () => RespondentCriteriaDetailsScreen()),
    GetPage(name: AppRoutes.transactionReview, page: () => TransactionReviewScreen()),
    GetPage(name: AppRoutes.transactionReviewRespondent, page: () => TransactionReviewRespondentScreen()),

    GetPage(name: AppRoutes.paymentGateway, page: () => PaymentGatewayScreen()),
    GetPage(name: AppRoutes.paymentConfirmation, page: () => PaymentConfirmationScreen()),

  ];
}
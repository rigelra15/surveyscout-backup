import 'package:get/get.dart';
// Since each screen collects different inputs, we use a ProjectController to store the data temporarily.

class ProjectController extends GetxController {
  var recruitmentType = "".obs;  // Surveyor or Respondent
  var projectTitle = "".obs;
  var projectDescription = "".obs;
  var respondentCriteria = {}.obs;
  var price = 0.obs;
  var paymentStatus = "".obs;

  void setRecruitmentType(String type) => recruitmentType.value = type;
  void setProjectTitle(String title) => projectTitle.value = title;
  void setProjectDescription(String desc) => projectDescription.value = desc;
  void setRespondentCriteria(Map<String, dynamic> criteria) => respondentCriteria.assignAll(criteria);
  void setPrice(int amount) => price.value = amount;
  void setPaymentStatus(String status) => paymentStatus.value = status;
}
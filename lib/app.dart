import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyscout/routes/app_routes.dart';
import 'controllers/client/project_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_pages.dart';

class SurveyScoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ProjectController());
    // Get.put(AuthController());
    // Get.put(PaymentController());

    //using approutes
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SurveyScout',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
      initialRoute: AppRoutes.paymentConfirmationTimeout, // 👈 Change this anytime
      getPages: AppPages.pages,
    );
  }
}

  import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../storage/storage_helper.dart';
class DashboardController extends GetxController {
@override
  void onInit() {
    super.onInit();
    // _checkUserVerification();
  }

  Future<void> _checkUserVerification() async {
    final isVerified = await StorageHelper.isUserVerified();
    if (!isVerified) {
      Get.offNamed(Routes.verification); // Redirect to verification screen if not verified
    }
  }}
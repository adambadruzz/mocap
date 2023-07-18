import 'package:get/get.dart';

import '../view/chat_view.dart';
import '../view/home_view.dart';
import '../view/profile_view.dart';

class NavigationBarViewModel extends GetxController {
  final RxInt currentIndex = 0.obs;

  void onTabSelected(int index) {
    currentIndex.value = index;

    // Navigasi berdasarkan tab yang dipilih
    switch (currentIndex.value) {
      case 0:
        Get.offAll(() => HomeView());
        break;
      case 1:
        Get.offAll(() => ChatView());
        break;
      case 2:
        Get.offAll(() => ProfileView());
        break;
    }
  }
}

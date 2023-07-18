import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mocap/view/login_view.dart';
import 'package:mocap/view/register_view.dart';
import '../services/auth_service.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/home_viemodel.dart';
import '../viewmodel/register_viewmodel.dart';
import 'home_view.dart';
import '../viewmodel/login_viewmodel.dart';
import 'waiting_view.dart'; // Import waiting_view.dart


class AuthPage extends GetView<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.user != null) {
          final access = controller.getUserAccess();
          if (access == null) {
            // User access is null, navigate to register view
            Future.delayed(Duration.zero, () {
              Get.offAll(() => RegisterView(),
                  binding: BindingsBuilder(() => [
                        Get.put(AuthService()),
                        Get.put(RegisterViewModel()),
                      ]));
            });
            return Container();
          } else if (access == 'Denied' ||
              access == 'Granted' ||
              access == 'Pending' ||
              access == 'OK' ||
              access == 'Approved') {
            // Show waiting view if access is denied, granted, pending, or OK
            return WaitingView();
          } else {
            // User has valid access, navigate to home view
            Future.delayed(Duration.zero, () {
              Get.offAll(() => HomeView(),
                  binding: BindingsBuilder(() => [
                        Get.put(HomeViewModel()),
                      ]));
            });
            return Container();
          }
        } else {
          // User is not logged in, navigate to login view
          Future.delayed(Duration.zero, () {
            Get.offAll(() => LoginView(),
                binding: BindingsBuilder(() => [
                      Get.put(AuthService()),
                      Get.put(LoginViewModel(authService: AuthService())),
                    ]));
          });
          return Container();
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/resetpass_viewmodel.dart';

class ResetPasswordView extends StatelessWidget {
  final ResetPasswordViewModel viewModel = Get.put(ResetPasswordViewModel());

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Enter Your Email Address", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (emailController.text.isNotEmpty) {
                  viewModel.resetPassword(
                    email: emailController.text,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

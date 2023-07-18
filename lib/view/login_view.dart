import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/register_viewmodel.dart';
import '../viewmodel/resetpass_viewmodel.dart';
import 'register_view.dart';
import 'resetpass_view.dart';

class LoginView extends GetWidget<LoginViewModel> {
  LoginView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _restartApp(BuildContext context) {
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Text('Welcome', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text(
                "Welcome back you've been missed!",
                style: TextStyle(fontSize: 15),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => ResetPasswordView(
                              
                            ));
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.signIn(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
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
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black)),
                    Text('or continue with', style: TextStyle(fontSize: 15)),
                    Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.signInWithGoogle(context: context);
                      },
                      child: Image.asset(
                        'assets/images/google.png',
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.signInGuest(
                          email: 'guest@gmail.com',
                          password: '123456',
                          context: context,
                        );
                      },
                      child: Image.asset(
                        'assets/images/guest.png',
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?', style: TextStyle(fontSize: 15)),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegisterView(
                        ));
                      },
                      child: const Text('Register', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _restartApp(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

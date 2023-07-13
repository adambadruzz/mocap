import 'package:flutter/material.dart';
import 'package:mocap/view/register_view.dart';
import 'package:mocap/view/resetpass_view.dart';
import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/register_viewmodel.dart';
import '../viewmodel/resetpass_viewmodel.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginView({Key? key, required this.viewModel}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              const Text("Welcome back you've been missed!", style: TextStyle(fontSize: 15)),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPasswordView(viewModel: ResetPasswordViewModel(authService: AuthService()))),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.signIn(
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
                        viewModel.signInWithGoogle(context: context);
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
                        viewModel.signInGuest(
                          email: 'guest@gmail.com',
                          password: '123456',
                          context: context,);
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterView(viewModel: RegisterViewModel(authService: AuthService()))),
                        );
                      },
                      child: const Text('Register', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mocap/view/register_view.dart';
import 'package:mocap/view/resetpass_view.dart';

import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/register_viewmodel.dart';
import '../viewmodel/resetpass_viewmodel.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginView({required this.viewModel});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text('Welcome', style: TextStyle(fontSize: 20)),
              SizedBox(height: 50),
              Text("Welcome back you've been missed!", style: TextStyle(fontSize: 15)),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                      child: Text('Forgot Password?'),
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
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black)),
                    Text('or continue with', style: TextStyle(fontSize: 15)),
                    Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                      //  viewModel.signInWithGoogle();
                      },
                      child: Image.asset(
                        'assets/images/google.png',
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?', style: TextStyle(fontSize: 15)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterView(viewModel: RegisterViewModel(authService: AuthService()))),
                        );
                      },
                      child: Text('Register', style: TextStyle(color: Colors.blue)),
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

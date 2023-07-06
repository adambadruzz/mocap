import 'package:flutter/material.dart';
import 'package:mocap/view/register_view.dart';

import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/register_viewmodel.dart';
import '../viewmodel/resetpass_viewmodel.dart';

class ResetPasswordView extends StatelessWidget {
  final ResetPasswordViewModel viewModel;

  ResetPasswordView({required this.viewModel});

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: 
      Column(children: [
        SizedBox(height: 20),
        Text("Enter Your Email Address", style: TextStyle(fontSize: 15)),
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
              GestureDetector(
                onTap: () {
                  viewModel.resetPassword(
                    email: emailController.text,
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
                      'Reset Password',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
      ]),)
    );
  }
}

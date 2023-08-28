import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/textfield_dec.dart';
import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/register_viewmodel.dart';
import '../viewmodel/resetpass_viewmodel.dart';
import 'register_view.dart';
import 'resetpass_view.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginView({Key? key, required this.viewModel}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _restartApp(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(paddingL),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back!',
                    style: customTextStyle(32.0, FontWeight.w900, black)),
                const SizedBox(height: paddingM),
                Text('Sign In',
                    style: customTextStyle(32.0, FontWeight.w900, black)),
                const SizedBox(height: paddingM),
                TextField(
                  controller: emailController,
                  decoration: customTextFieldDecoration('Email'),
                ),
                const SizedBox(height: paddingM),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: customTextFieldDecoration('Password'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordView(
                            viewModel: ResetPasswordViewModel(
                              authService: AuthService(),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text('Forgot Password?',
                        style:
                            customTextStyle(14.0, FontWeight.w600, blueFigma)),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF406EA5),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: paddingM),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black)),
                    SizedBox(width: paddingM),
                    Text('or continue with', style: TextStyle(fontSize: 15)),
                    SizedBox(width: paddingM),
                    Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: paddingM),
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
                    const SizedBox(width: paddingM),
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
                const SizedBox(height: paddingM),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?',
                          style: customTextStyle(14.0, FontWeight.w500, black)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(
                                viewModel: RegisterViewModel(
                                  authService: AuthService(),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text('Register',
                            style: customTextStyle(
                                14.0, FontWeight.w500, blueFigma)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => _restartApp(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

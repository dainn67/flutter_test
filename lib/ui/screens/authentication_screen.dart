import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:routing_app/providers/auth_provider.dart';
import 'package:routing_app/routes/route_config.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/ui/components/main_button.dart';

enum AuthenticationType { signIn, signUp }

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late AuthenticationType type;

  @override
  void initState() {
    type = AuthenticationType.signIn;

    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        emailController.text = 'nguyendai060703@gmail.com';
        passwordController.text = '111111';
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(title: const Text('Authentication')),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTextField('Email', emailController),
                  if (type == AuthenticationType.signUp) _buildTextField('Username', confirmPasswordController),
                  _buildTextField('Password', passwordController, isPassword: true),
                  if (type == AuthenticationType.signUp) _buildTextField('Confirm Password', confirmPasswordController, isPassword: true),

                  // Buttons
                  Selector<AuthProvider, bool>(
                    selector: (_, provider) => provider.authState == AuthState.loading,
                    builder: (_, loading, __) => MainButton(
                      title: type == AuthenticationType.signIn ? 'Sign In' : 'Create',
                      isSelected: true,
                      isLoading: loading,
                      onPressed: type == AuthenticationType.signIn ? _onSignIn : _onRegister,
                    ),
                  ),
                  MainButton(
                      title: type == AuthenticationType.signIn ? 'Sign Up' : 'Sign In',
                      onPressed: () {
                        setState(() {
                          if (type == AuthenticationType.signIn) {
                            type = AuthenticationType.signUp;
                          } else {
                            type = AuthenticationType.signIn;
                          }
                        });
                      })
                ],
              ),
            ),
          ],
        ),
      ),
      Selector<AuthProvider, bool>(
        selector: (_, provider) => provider.authState == AuthState.loading,
        builder: (_, loading, __) => loading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
      ),
    ]);
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool isPassword = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: hint,
            prefixIcon: Icon(isPassword ? Icons.lock : Icons.person),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 16),
        ),
      );

  _onSignIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Email or Password empty');
      return;
    }

    context.read<AuthProvider>().handleSignIn(email, password).then((data) {
      if (data != null) RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.home, '/');
    });
  }

  _onRegister() async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: 'Confirm password not match !');
      return;
    }
  }
}

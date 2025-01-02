import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routing_app/models/auth_user.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_repo.dart';
import 'package:routing_app/services/log_service.dart';
import 'package:routing_app/ui/components/main_button.dart';

enum AuthenticationType { signIn, signUp }

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late AuthenticationType type;

  @override
  void initState() {
    type = AuthenticationType.signIn;

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTextField('Email', emailController),
            _buildTextField('Password', passwordController, isPassword: true),
            if (type == AuthenticationType.signUp) _buildTextField('Confirm Password', confirmPasswordController, isPassword: true),
            MainButton(
              title: type == AuthenticationType.signIn ? 'Sign In' : 'Create',
              isSelected: true,
              onPressed: type == AuthenticationType.signIn ? _onSignIn : _onRegister,
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
    );
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

  _onSignIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('signing in with $email - $password');

    if (email.isEmpty || password.isEmpty) Fluttertoast.showToast(msg: 'Email or Password empty');

    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      printSuccess('name: ${credential.user?.displayName}');
      printSuccess('email: ${credential.user?.email}');
      printSuccess('refreshToken: ${credential.user?.refreshToken}');
      printSuccess('idToken: ${await credential.user?.getIdToken()}');
      final user = credential.user;

      final authUser = AuthUser(
        username: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        refreshToken: user?.refreshToken,
        idToken: user?.refreshToken,
        uid: user?.uid,
      );

      final authUserJson = jsonEncode(authUser.toJson());

      SharedPreferencesRepo.instance.saveAuthUser(authUserJson);

      Fluttertoast.showToast(msg: 'Sign In Success !');
    } catch (e) {
      print('SignIn Error: $e');
      Fluttertoast.showToast(msg: 'Sign In Failed !');
    }
  }

  _onRegister() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: 'Confirm password not match !');
      return;
    }

    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      printSuccess('Credential: ${credential.user?.refreshToken}');
    } catch (e) {
      print('SignUp Error: $e');
      _checkError(e.toString());
    }
  }

  _checkError(String e) {
    if (e.contains('email-already-in-use')) {
      Fluttertoast.showToast(msg: 'Account already exists');
    }
  }
}

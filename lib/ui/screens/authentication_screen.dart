import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_event.dart';
import 'package:routing_app/blocs/authentication/authentication_state.dart';
import 'package:routing_app/ui/components/main_button.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) => Text(
                      state.toString(),
                      textAlign: TextAlign.center,
                    )),
            MainButton(
                title: 'Sign In',
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignInEvent());
                }),
            MainButton(
                title: 'Sign Up',
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignUpEvent());
                })
          ],
        ),
      ),
    );
  }
}

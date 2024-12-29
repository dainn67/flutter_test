import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_event.dart';
import 'package:routing_app/blocs/authentication/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState('', '', '')) {
    on<SignInEvent>(_handleSignIn);
    on<SignUpEvent>(_handleSignUp);
  }

  _handleSignIn(AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    print('Signing In ...');
    emit(AuthenticationState('dainn@gmail.com', 'dainn', '11111'));
  }

  _handleSignUp(AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    print('Signing Up ...');
    emit(AuthenticationState('newacc@gmail.com', 'newacc', '11111'));
  }
}
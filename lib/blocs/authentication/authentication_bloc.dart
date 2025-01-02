import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routing_app/blocs/authentication/authentication_event.dart';
import 'package:routing_app/blocs/authentication/authentication_state.dart';
import 'package:routing_app/repositories/sqlite/topic_repo.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.topicRepository) : super(AuthenticationState('', '', '')) {
    on<SignInEvent>(_handleSignIn);
    on<SignUpEvent>(_handleSignUp);
  }

  final TopicRepository topicRepository;

  _handleSignIn(AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    final signInEvent = event as SignInEvent;
    final email = signInEvent.email;
    final password = signInEvent.password;

    if (email.contains('dainn') && password == '1111') {
      Fluttertoast.showToast(msg: 'Login success!');
    } else {
      Fluttertoast.showToast(msg: 'Invalid email/password!');
    }
    emit(AuthenticationState('dainn@gmail.com', 'dainn', '11111'));
  }

  _handleSignUp(AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    topicRepository.getTopicsByParentId(1000).then((data) {
      print('Get: ${data?.length} topics');
    });
    emit(AuthenticationState('newacc@gmail.com', 'newacc', '11111'));
  }
}

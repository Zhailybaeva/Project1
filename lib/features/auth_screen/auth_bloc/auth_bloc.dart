import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_edus_kz/features/auth_screen/auth_bloc/auth_event.dart';
import 'package:ok_edus_kz/features/auth_screen/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BuildContext context;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc(this.context) : super(AuthInitialState()) {
    on<LoginEvent>(_onLogin);
  }
  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.login,
        password: event.password,
      );

      if (userCredential.user != null) {
        emit(AuthLoggedInState());
      } else {
        emit(AuthErrorState('Что-то пошло не так'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}

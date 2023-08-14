import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      prefs.setBool('isAuth', true);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      prefs.setBool('isAuth', false);
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      } else if (ex.code == 'invalid-email') {
        emit(LoginFailure(errorMessage: 'invalid-email'));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errorMessage: 'network failure'));
      }
    } catch (e) {
      prefs.setBool('isAuth', false);
      emit(LoginFailure(errorMessage: 'some thing went wrong'));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(ResetPasswordStarted());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      emit(ResetPasswordSuccessed());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(ResetPasswordFailed(errMessage: 'user not found'));
      } else if (ex.code == 'invalid-email') {
        emit(ResetPasswordFailed(errMessage: 'invalid-email'));
      }
    } catch (e) {
      emit(ResetPasswordFailed(errMessage: 'some thing went wrong'));
    }
  }
}

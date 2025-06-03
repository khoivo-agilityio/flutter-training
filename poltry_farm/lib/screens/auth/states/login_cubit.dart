import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void emailChanged(String? value) {
    emit(state.copyWith(
      email: state.email.copyWith(text: value),
    ));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: state.password.copyWith(text: value)));
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: LoginStatus.loading));

    // FIXME: Replace with actual authentication logic
    await Future.delayed(const Duration(seconds: 2)); // mock API call

    if (state.email.text == 'khoi.vo@asnet.com' &&
        state.password.text == 'abcABC@123') {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: S.current.errorInvalidEmailOrPassword,
      ));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(LoginState.initial());

  final AuthRepository _authRepository;

  void emailChanged(String? value) {
    emit(
      state.copyWith(
        email: state.email.copyWith(
          text: value,
        ),
      ),
    );
  }

  void passwordChanged(String? value) {
    emit(
      state.copyWith(
        password: state.password.copyWith(
          text: value,
        ),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(
      status: LoginStatus.loading,
    ));

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email.text,
        password: state.password.text,
      );

      emit(state.copyWith(
        status: LoginStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: S.current.errorInvalidEmailOrPassword,
      ));
    }
  }
}

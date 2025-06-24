import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/widgets/form_input.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void emailChanged(String email) {
    final newEmail = PfEmailInput.pure(email);

    emit(
      state.copyWith(
        email: newEmail,
        status: LoginStatus.success,
      ),
    );
  }

  void emailValidation(String email) {
    emit(
      state.copyWith(
        email: PfEmailInput.dirty(email),
        status: LoginStatus.success,
      ),
    );
  }

  void passwordChanged(String password) {
    emit(
      state.copyWith(
        password: PfPasswordInput.dirty(password),
        status: LoginStatus.success,
      ),
    );
  }

  void passwordValidation(String password) {
    emit(
      state.copyWith(
        password: PfPasswordInput.dirty(password),
        status: LoginStatus.success,
      ),
    );
  }

  void passwordVisibilityChanged() {
    emit(
      state.copyWith(
        isObscured: !state.isObscured,
        status: LoginStatus.success,
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(
      status: LoginStatus.loading,
    ));

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(state.copyWith(
        status: LoginStatus.loginedSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: S.current.errorInvalidEmailOrPassword,
      ));
    }
  }
}

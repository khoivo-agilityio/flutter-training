part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final PfPlainTextFormFieldSubState email;
  final PfPlainTextFormFieldSubState password;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    PfPlainTextFormFieldSubState? email,
    PfPlainTextFormFieldSubState? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.initial() {
    return LoginState(
      email: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.loginFormEmailSemanticLabel,
        label: S.current.loginFormEmailLabel,
        hintText: S.current.loginFormEmailHint,
        focusNode: FocusNode(),
        text: '',
        validators: const [
          PfFormValidators.required,
          PfFormValidators.email,
        ],
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
      password: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.loginFormPasswordSemanticLabel,
        label: S.current.loginFormPasswordLabel,
        hintText: S.current.loginFormPasswordHint,
        focusNode: FocusNode(),
        text: '',
        validators: const [
          PfFormValidators.required,
          PfFormValidators.password,
        ],
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
      status: LoginStatus.initial,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}

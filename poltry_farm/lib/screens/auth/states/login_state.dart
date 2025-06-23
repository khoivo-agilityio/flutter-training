part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure, loginedSuccess }

final class LoginState extends Equatable {
  const LoginState({
    this.email = const PfEmailInput.pure(),
    this.password = const PfPasswordInput.pure(),
    this.status = LoginStatus.initial,
    this.isObscured = true,
    this.errorMessage,
  });

  final PfEmailInput email;
  final PfPasswordInput password;
  final LoginStatus status;
  final String? errorMessage;
  final bool isObscured;

  LoginState copyWith({
    PfEmailInput? email,
    PfPasswordInput? password,
    LoginStatus? status,
    bool? isObscured,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isObscured: isObscured ?? this.isObscured,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isValid => Formz.validate([email, password]);

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        isObscured,
      ];
}

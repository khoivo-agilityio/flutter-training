import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/screens/auth/states/login_cubit.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/widgets/forms/form_input.dart';
import 'auth_mocks.mocks.dart';

void main() {
  late LoginCubit loginCubit;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginCubit = LoginCubit(mockAuthRepository);
    S.load(const Locale('en'));
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    test('initial state is correct', () {
      expect(loginCubit.state, const LoginState());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [email updated, success] when emailChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.emailChanged('test@example.com'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.email.value, 'email', 'test@example.com')
            .having((s) => s.status, 'status', LoginStatus.success),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [password updated, success] when passwordChanged is called',
      build: () => loginCubit,
      act: (cubit) => cubit.passwordChanged('Abc12345!'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.password.value, 'password', 'Abc12345!')
            .having((s) => s.status, 'status', LoginStatus.success),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'toggles password visibility',
      build: () => loginCubit,
      act: (cubit) => cubit.passwordVisibilityChanged(),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.isObscured, 'isObscured', false)
            .having((s) => s.status, 'status', LoginStatus.success),
      ],
    );

    const testUser = PfUserModel(uid: '123', email: 'test@example.com');

    blocTest<LoginCubit, LoginState>(
      'emits [loading, loginedSuccess] when login succeeds',
      build: () {
        when(mockAuthRepository.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => testUser);

        when(mockAuthRepository.getUserData(any))
            .thenAnswer((_) async => testUser);

        return LoginCubit(mockAuthRepository);
      },
      seed: () => const LoginState(
        email: PfEmailInput.dirty('khoi.vo@asnet.com.vn'),
        password: PfPasswordInput.dirty('abcABC@123'),
      ),
      act: (cubit) => cubit.logInWithCredentials(),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.loading),
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.loginedSuccess),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, failure] when login fails',
      build: () {
        when(mockAuthRepository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'wrongPass1!!',
        )).thenThrow(Exception('Failed'));

        return LoginCubit(mockAuthRepository);
      },
      seed: () => const LoginState(
        email: PfEmailInput.dirty('test@example.com'),
        password: PfPasswordInput.dirty('wrongPass1!'),
      ),
      act: (cubit) => cubit.logInWithCredentials(),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.loading),
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.failure)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });
}

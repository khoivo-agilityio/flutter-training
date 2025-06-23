import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';

import 'package:poltry_farm/screens/auth/states/login_cubit.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/forms/form_input.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';

import 'auth_mocks.mocks.dart';

class FakeFormField extends PfPlainTextFormFieldSubState {
  FakeFormField({
    required super.text,
  }) : super(
          label: 'label',
          hintText: 'hint',
          semanticsLabel: 'semantic',
          focusNode: FocusNode(),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          validators: const [PfFormValidators.required],
        );
}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  const dummyUser = PfUserModel(
    uid: '123',
    name: 'Test User',
    email: 'test@example.com',
    farmName: '',
    country: '',
    state: '',
    city: '',
    village: '',
    farmCapacity: '',
    farmType: '',
    avatarUrl: '',
  );

  group('LoginCubit', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // fake the localization delegate
      S.load(const Locale('en'));
    });

    test('initial state is correct', () {
      final cubit = LoginCubit(mockAuthRepository);
      expect(cubit.state.status, LoginStatus.initial);
      expect(cubit.state.email.text, '');
      expect(cubit.state.password.text, '');
    });

    blocTest<LoginCubit, LoginState>(
      'emits updated email when emailChanged is called',
      build: () => LoginCubit(mockAuthRepository),
      act: (cubit) => cubit.emailChanged('test@example.com'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.email.text, 'email.text', 'test@example.com'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits updated password when passwordChanged is called',
      build: () => LoginCubit(mockAuthRepository),
      act: (cubit) => cubit.passwordChanged('password123'),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.password.text, 'password.text', 'password123'),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, success] on successful login',
      build: () {
        when(mockAuthRepository.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => dummyUser);
        return LoginCubit(mockAuthRepository);
      },
      seed: () => LoginState.initial().copyWith(
        email: FakeFormField(text: 'test@example.com'),
        password: FakeFormField(text: 'password123'),
      ),
      act: (cubit) => cubit.logInWithCredentials(),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.loading),
        isA<LoginState>()
            .having((s) => s.status, 'status', LoginStatus.success),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [loading, failure] on login error',
      build: () {
        when(mockAuthRepository.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(Exception('Login failed'));
        return LoginCubit(mockAuthRepository);
      },
      seed: () => LoginState.initial().copyWith(
        email: FakeFormField(text: 'fail@example.com'),
        password: FakeFormField(text: 'wrongpass'),
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

///

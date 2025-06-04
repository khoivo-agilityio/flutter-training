import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/router.dart';

import 'package:poltry_farm/screens/auth/states/login_cubit.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/forms/form_control.dart';

class PfLoginScreen extends StatefulWidget {
  const PfLoginScreen({super.key});

  @override
  State<PfLoginScreen> createState() => _PfLoginScreenState();
}

class _PfLoginScreenState extends State<PfLoginScreen> {
  late final LoginCubit _loginCubit;
  @override
  void initState() {
    _loginCubit = LoginCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocListener<LoginCubit, LoginState>(
          bloc: _loginCubit,
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              context.goNamed(PfPaths.home.name);
            } else if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage ?? 'Login Failed')));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PfFormControls.textBloc<LoginCubit, LoginState>(
                  selector: (state) => state.email,
                  onChanged: (value) => _loginCubit.emailChanged(value),
                ),
                const SizedBox(height: 20),
                PfFormControls.textBloc<LoginCubit, LoginState>(
                  selector: (state) => state.password,
                  onChanged: (value) => _loginCubit.passwordChanged(value),
                ),
                const SizedBox(height: 20),
                BlocSelector<LoginCubit, LoginState, bool>(
                  selector: (state) => state.status == LoginStatus.loading,
                  builder: (context, hasLoading) {
                    return PfElevatedButton(
                      semanticsLabel: S.current.loginPageLoginButton,
                      onPressed: hasLoading
                          ? null
                          : () => _loginCubit.logInWithCredentials(),
                      child: hasLoading
                          ? const CircularProgressIndicator()
                          : Text(S.current.loginPageLoginButton),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

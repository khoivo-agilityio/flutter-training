import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/screens/auth/states/login_cubit.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/forms/form_control.dart';

class PfLoginScreen extends StatelessWidget {
  const PfLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login Successful')));
            } else if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage ?? 'Login Failed')));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PfFormControls.textBloc<LoginCubit, LoginState>(
                    selector: (state) => state.email,
                    onChanged: context.read<LoginCubit>().emailChanged,
                  ),
                  const SizedBox(height: 20),
                  PfFormControls.textBloc<LoginCubit, LoginState>(
                    selector: (state) => state.password,
                    onChanged: context.read<LoginCubit>().passwordChanged,
                  ),
                  const SizedBox(height: 20),
                  PfElevatedButton(
                    semanticsLabel: 'Login Button',
                    onPressed: state.status == LoginStatus.loading
                        ? null
                        : () =>
                            context.read<LoginCubit>().logInWithCredentials(),
                    child: state.status == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

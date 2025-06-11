import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/router.dart';

import 'package:poltry_farm/screens/auth/states/login_cubit.dart';
import 'package:poltry_farm/widgets/assets.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/forms/form_control.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfLoginScreen extends StatefulWidget {
  const PfLoginScreen({super.key});

  @override
  State<PfLoginScreen> createState() => _PfLoginScreenState();
}

class _PfLoginScreenState extends State<PfLoginScreen> {
  late final LoginCubit _loginCubit;
  @override
  void initState() {
    _loginCubit = LoginCubit(context.read<AuthRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _loginCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                PfText(
                  text: S.current.loginPageTitle,
                  variant: PfTextStyleVariant.displaySmall,
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(
                  height: 64,
                ),
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<LoginCubit, LoginState>(
                    selector: (state) => state.email,
                    onChanged: (value) => _loginCubit.emailChanged(value),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<LoginCubit, LoginState>(
                    selector: (state) => state.password,
                    onChanged: (value) => _loginCubit.passwordChanged(value),
                  ),
                ),
                const SizedBox(height: 24),
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
                const Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            height: 1,
                            color: context.colorScheme.outline,
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        PfText(
                          text: 'Or Login with',
                          variant: PfTextStyleVariant.labelMedium,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          height: 1,
                          color: context.colorScheme.outline,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: context.colorScheme.outline,
                                )),
                            child: PfAssets.facebookIc(),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: context.colorScheme.outline,
                                )),
                            child: PfAssets.googleIc(),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: context.colorScheme.outline,
                                )),
                            child: PfAssets.cibApple(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PfText(
                      text: S.current.loginPageFooter,
                      variant: PfTextStyleVariant.labelLarge,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    PfText(
                      text: S.current.loginPageFooterAction,
                      variant: PfTextStyleVariant.labelLarge,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

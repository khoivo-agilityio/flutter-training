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
import 'package:poltry_farm/widgets/text.dart';
import 'package:poltry_farm/widgets/text_field.dart';

class PfLoginScreen extends StatefulWidget {
  const PfLoginScreen({super.key});

  @override
  State<PfLoginScreen> createState() => _PfLoginScreenState();
}

class _PfLoginScreenState extends State<PfLoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthRepository>()),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.loginedSuccess) {
                // hide snackbar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.goNamed(PfPaths.home.name);
              } else if (state.status == LoginStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage ?? 'Login Failed')));
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                  _EmailInput(_emailFocusNode),
                  const SizedBox(
                    height: 8,
                  ),
                  _PasswordInput(_passwordFocusNode),
                  const SizedBox(height: 24),
                  BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) => state.status == LoginStatus.loading,
                    builder: (context, hasLoading) {
                      return PfElevatedButton(
                        semanticsLabel: S.current.loginPageLoginButton,
                        onPressed: hasLoading
                            ? null
                            : () => context
                                .read<LoginCubit>()
                                .logInWithCredentials(),
                        child: hasLoading
                            ? const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: CircularProgressIndicator(),
                              )
                            : PfText(
                                text: S.current.loginPageLoginButton,
                                variant: PfTextStyleVariant.titleMedium,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onPrimary,
                              ),
                      );
                    },
                  ),
                  const Spacer(),
                  const _SocialLogin(),
                  const Spacer(),
                  const _CreateAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccount extends StatelessWidget {
  const _CreateAccount();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
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
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class _SocialLogin extends StatelessWidget {
  const _SocialLogin();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              text: S.current.loginPageInstruction,
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
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return PfTextField(
          key: const Key('loginForm_emailInput_textField'),
          semanticsLabel: S.current.formEmailSemanticLabel,
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
          hintText: S.of(context).formEmailHint,
          errorMessage: state.email.displayError != null
              ? S.of(context).loginFormValidateEmail
              : null,
          onTapOutside: () =>
              context.read<LoginCubit>().emailValidation(state.email.value),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isObscured != current.isObscured,
      builder: (context, state) {
        return PfTextField(
          key: const Key('loginForm_passwordInput_textField'),
          focusNode: focusNode,
          semanticsLabel: S.current.loginFormPasswordSemanticLabel,
          hintText: S.of(context).loginFormPasswordHint,
          obscureText: state.isObscured,
          errorMessage: state.password.displayError != null
              ? S.of(context).loginFormValidatePassword
              : null,
          onTapOutside: () => context
              .read<LoginCubit>()
              .passwordValidation(state.password.value),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          suffixIcon: IconButton(
            onPressed: context.read<LoginCubit>().passwordVisibilityChanged,
            icon: Icon(
              !state.isObscured
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: context.colorScheme.onSurface,
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/screens/settings/states/personal_info_cubit.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/avartar.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/dropdown.dart';
import 'package:poltry_farm/widgets/form_input.dart';
import 'package:poltry_farm/widgets/scroll_keyboard_manager.dart';
import 'package:poltry_farm/widgets/text.dart';
import 'package:poltry_farm/widgets/text_field.dart';

class PfPersonalInfoScreen extends StatefulWidget {
  const PfPersonalInfoScreen({super.key});

  @override
  State<PfPersonalInfoScreen> createState() => _PfPersonalInfoScreenState();
}

class _PfPersonalInfoScreenState extends State<PfPersonalInfoScreen> {
  late final PersonalInfoCubit _cubit;
  late TextEditingController _farmController;
  late Box<UserDbModel> _userBox;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _farmNameFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _villageFocusNode = FocusNode();
  final FocusNode _farmCapacityFocusNode = FocusNode();
  final FocusNode _farmFocusNode = FocusNode();

  @override
  void initState() {
    _cubit = PersonalInfoCubit(authRepository: context.read<AuthRepository>());
    _farmController = TextEditingController();
    _userBox = Hive.box<UserDbModel>('userBox');
    super.initState();
  }

  @override
  void dispose() {
    _farmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit
        ..initialForm(
          nameValue: _userBox.get('userBox')?.name ?? '',
          emailValue: _userBox.get('userBox')?.email ?? '',
          avatarUrlValue: _userBox.get('userBox')?.avatarUrl ?? '',
          farmNameValue: _userBox.get('userBox')?.farmName ?? '',
          countryValue: _userBox.get('userBox')?.country ?? '',
          stateValue: _userBox.get('userBox')?.state ?? '',
          cityValue: _userBox.get('userBox')?.city ?? '',
          villageValue: _userBox.get('userBox')?.village ?? '',
          farmCapacityValue: _userBox.get('userBox')?.farmCapacity ?? '',
          farmValue: _userBox.get('userBox')?.farmType ?? '',
        ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PfAppBar(
          title: S.current.userInfomationPageTitle,
        ),
        body: ScrollKeyboardManager(
          focusNodes: [
            _farmFocusNode,
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                  buildWhen: (p, c) => p.avartarImg != c.avartarImg,
                  builder: (context, state) {
                    return _Avatar(
                      userBox: _userBox,
                      onTap: () {
                        _cubit.changeAvatar();
                      },
                      avartarFile: state.avartarImg,
                    );
                  },
                ),
                const SizedBox(height: 24),
                _NameInput(_nameFocusNode),
                const SizedBox(height: 24),
                _EmailInput(_emailFocusNode),
                const SizedBox(height: 4),
                _FarmNameInput(_farmNameFocusNode),
                const SizedBox(height: 24),
                _CountryInput(_countryFocusNode),
                const SizedBox(height: 24),
                _StateInput(_stateFocusNode),
                const SizedBox(height: 24),
                _CityInput(_cityFocusNode),
                const SizedBox(height: 24),
                _VillageInput(_villageFocusNode),
                const SizedBox(height: 24),
                _FarmCapacityInput(_farmCapacityFocusNode),
                const SizedBox(height: 20),
                _FarmInput(_farmFocusNode),
                const SizedBox(height: 24),
                BlocSelector<PersonalInfoCubit, PersonalInfoState, bool>(
                  selector: (state) =>
                      state.status == PersonalInfoStatus.loading,
                  builder: (context, hasLoading) {
                    return PfElevatedButton(
                      semanticsLabel: S.current.generalSave,
                      onPressed:
                          hasLoading ? null : () => _cubit.savePersonalInfo(),
                      child: hasLoading
                          ? const CircularProgressIndicator()
                          : PfText(
                              text: S.current.generalSave,
                              variant: PfTextStyleVariant.titleMedium,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onPrimary,
                            ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.userBox,
    required this.onTap,
    this.avartarFile,
  });

  final Box<UserDbModel> userBox;
  final VoidCallback onTap;
  final File? avartarFile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BoxEvent>(
      stream: userBox.watch(),
      builder: (context, snapshot) {
        return Hero(
          tag: 'avatar',
          child: Material(
            color: Colors.transparent,
            child: PfAvatar(
              imageFile: avartarFile,
              imgUrl: userBox.get('userBox')?.avatarUrl ?? '',
              size: 96,
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfNameInput>(
      selector: (state) => state.name,
      builder: (context, name) {
        return PfTextField(
          key: const Key('personalInfoForm_NameInput_textField'),
          semanticsLabel: S.current.formNameSemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().nameChanged(value),
          hintText: S.of(context).formNameHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: name.value,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfEmailInput>(
      selector: (state) => state.email,
      builder: (context, email) {
        return PfTextField(
          key: const Key('personalInfoForm_EmailInput_textField'),
          semanticsLabel: S.current.formEmailSemanticLabel,
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().emailChanged(value),
          hintText: S.of(context).formEmailHint,
          errorMessage: email.displayError != null
              ? S.of(context).loginFormValidateEmail
              : null,
          onTapOutside: () =>
              context.read<PersonalInfoCubit>().emailValidation(email.value),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _FarmNameInput extends StatelessWidget {
  const _FarmNameInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfFarmNameInput>(
      selector: (state) => state.farmName,
      builder: (context, name) {
        return PfTextField(
          key: const Key('personalInfoForm_FarmNameInput_textField'),
          semanticsLabel: S.current.formFarmNameSemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().farmNameChanged(value),
          hintText: S.of(context).formFarmNameHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: name.value,
        );
      },
    );
  }
}

class _CountryInput extends StatelessWidget {
  const _CountryInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfCountryInput>(
      selector: (state) => state.country,
      builder: (context, country) {
        return PfTextField(
          key: const Key('personalInfoForm_CountryInput_textField'),
          semanticsLabel: S.current.formCountrySemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().countryChanged(value),
          hintText: S.of(context).formCountryHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: country.value,
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  const _StateInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfStateInput>(
      selector: (state) => state.state,
      builder: (context, state) {
        return PfTextField(
          key: const Key('personalInfoForm_stateInput_textField'),
          semanticsLabel: S.current.formStateSemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().stateChanged(value),
          hintText: S.of(context).formStateHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: state.value,
        );
      },
    );
  }
}

class _CityInput extends StatelessWidget {
  const _CityInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfCityInput>(
      selector: (state) => state.city,
      builder: (context, city) {
        return PfTextField(
          key: const Key('personalInfoForm_CityInput_textField'),
          semanticsLabel: S.current.formCitySemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().cityChanged(value),
          hintText: S.of(context).formCityHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: city.value,
        );
      },
    );
  }
}

class _VillageInput extends StatelessWidget {
  const _VillageInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfVillageInput>(
      selector: (state) => state.village,
      builder: (context, village) {
        return PfTextField(
          key: const Key('personalInfoForm_VillageInput_textField'),
          semanticsLabel: S.current.formVillageSemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().villageChanged(value),
          hintText: S.of(context).formVillageHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: village.value,
        );
      },
    );
  }
}

class _FarmCapacityInput extends StatelessWidget {
  const _FarmCapacityInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState,
        PfFarmCapacityInput>(
      selector: (state) => state.farmCapacity,
      builder: (context, farmCapacity) {
        return PfTextField(
          key: const Key('personalInfoForm_FarmCapacityInput_textField'),
          semanticsLabel: S.current.formFarmCapacitySemanticLabel,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) =>
              context.read<PersonalInfoCubit>().farmCapacityChanged(value),
          hintText: S.of(context).formFarmCapacityHint,
          hasValidation: false,
          textInputAction: TextInputAction.next,
          initValue: farmCapacity.value,
        );
      },
    );
  }
}

class _FarmInput extends StatelessWidget {
  const _FarmInput(this.focusNode);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PersonalInfoCubit, PersonalInfoState, PfFarmInput>(
      selector: (state) => state.farm,
      builder: (context, farm) {
        return PfDropdownSearch<String>(
          key: const Key('personalInfoForm_FarmInput_textField'),
          name: S.current.formFarmSemanticLabel,
          hintText: S.current.formFarmHint,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          onChanged: (value) {},
          onSelected: (value) {
            context.read<PersonalInfoCubit>().farmChanged(value ?? '');
          },
          onFetchItems: () async {
            return await context.read<PersonalInfoCubit>().loadFarmTypes();
          },
          initialValue: PfDropdownSearchItem(
            value: farm.value,
            label: farm.value,
          ),
        );
      },
    );
  }
}

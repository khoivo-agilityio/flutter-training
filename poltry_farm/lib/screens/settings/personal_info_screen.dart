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
import 'package:poltry_farm/widgets/forms/form_control.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfPersonalInfoScreen extends StatefulWidget {
  const PfPersonalInfoScreen({super.key});

  @override
  State<PfPersonalInfoScreen> createState() => _PfPersonalInfoScreenState();
}

class _PfPersonalInfoScreenState extends State<PfPersonalInfoScreen> {
  late final PersonalInfoCubit _cubit;
  late TextEditingController _farmController;
  late Box<UserDbModel> _userBox;

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
        backgroundColor: Colors.white,
        appBar: PfAppBar(
          title: S.current.userInfomationPageTitle,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
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
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<PersonalInfoCubit,
                      PersonalInfoState>(
                    selector: (state) => state.nameForm,
                    onChanged: (value) => _cubit.nameFormChanged(value),
                  ),
                ),
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<PersonalInfoCubit,
                      PersonalInfoState>(
                    selector: (state) => state.emailForm,
                    onChanged: (value) => _cubit.emailFormChanged(value),
                  ),
                ),
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<PersonalInfoCubit,
                      PersonalInfoState>(
                    selector: (state) => state.farmNameForm,
                    onChanged: (value) => _cubit.farmNameFormChanged(value),
                  ),
                ),
                SizedBox(
                  height: 95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 95,
                          child: PfFormControls.textBloc<PersonalInfoCubit,
                              PersonalInfoState>(
                            selector: (state) => state.countryForm,
                            onChanged: (value) =>
                                _cubit.countryFormChanged(value),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 95,
                          child: PfFormControls.textBloc<PersonalInfoCubit,
                              PersonalInfoState>(
                            selector: (state) => state.stateForm,
                            onChanged: (value) =>
                                _cubit.stateFormChanged(value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 95,
                          child: PfFormControls.textBloc<PersonalInfoCubit,
                              PersonalInfoState>(
                            selector: (state) => state.cityForm,
                            onChanged: (value) => _cubit.cityFormChanged(value),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 95,
                          child: PfFormControls.textBloc<PersonalInfoCubit,
                              PersonalInfoState>(
                            selector: (state) => state.villageForm,
                            onChanged: (value) =>
                                _cubit.villageFormChanged(value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 95,
                  child: PfFormControls.textBloc<PersonalInfoCubit,
                      PersonalInfoState>(
                    selector: (state) => state.farmCapacityForm,
                    onChanged: (value) => _cubit.farmCapacityFormChanged(value),
                  ),
                ),
                PfFormControls.dropdownBloc<PersonalInfoCubit,
                    PersonalInfoState>(
                  selector: (state) => state.farmForm,
                  // onChanged: (value) {},
                  onSelected: (value) {
                    _cubit.farmFormChanged(value);
                  },
                  onFetchItems: () async {
                    return await _cubit.loadFarmTypes();
                  },
                ),
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

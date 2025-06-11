import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/screens/settings/states/personal_info_cubit.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';
import 'package:poltry_farm/widgets/app_bar.dart';
import 'package:poltry_farm/widgets/avartar.dart';
import 'package:poltry_farm/widgets/button.dart';
import 'package:poltry_farm/widgets/dropdown.dart';
import 'package:poltry_farm/widgets/forms/form_control.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfPersonalInfoScreen extends StatefulWidget {
  const PfPersonalInfoScreen({super.key});

  @override
  State<PfPersonalInfoScreen> createState() => _PfPersonalInfoScreenState();
}

class _PfPersonalInfoScreenState extends State<PfPersonalInfoScreen> {
  late final PersonalInfoCubit _cubit;

  @override
  void initState() {
    _cubit = PersonalInfoCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hive = Hive.box<UserDbModel>('userBox');

    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PfAppBar(
          title: 'User Infomation',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                _Avatar(hive),
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
                PfDropdownSearch<String>(
                  name: 'Farm',
                  focusNode: FocusNode(),
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
                      semanticsLabel: 'Save',
                      onPressed:
                          hasLoading ? null : () => _cubit.savePersonalInfo(),
                      child: hasLoading
                          ? const CircularProgressIndicator()
                          : const Text('Save'),
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
  const _Avatar(this.hive);

  final Box<UserDbModel> hive;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BoxEvent>(
      stream: hive.watch(),
      builder: (context, snapshot) {
        final user = hive.get('userBox');

        return Hero(
          tag: 'avatar',
          child: Material(
            color: Colors.transparent,
            child: PfAvatar(imgUrl: user?.avatarUrl ?? '', size: 96),
          ),
        );
      },
    );
  }
}

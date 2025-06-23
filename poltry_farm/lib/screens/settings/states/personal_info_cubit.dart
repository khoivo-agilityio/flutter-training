import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/widgets/dropdown.dart';
import 'package:poltry_farm/widgets/forms/form_input.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          const PersonalInfoState(),
        );

  final AuthRepository _authRepository;

  void initialForm({
    String? nameValue,
    String? emailValue,
    String? avatarUrlValue,
    String? farmNameValue,
    String? countryValue,
    String? stateValue,
    String? cityValue,
    String? villageValue,
    String? farmCapacityValue,
    String? farmValue,
  }) {
    emit(
      state.copyWith(
        name: PfNameInput.pure(nameValue ?? ''),
        email: PfEmailInput.pure(emailValue ?? ''),
        farmName: PfFarmNameInput.pure(farmNameValue ?? ''),
        country: PfCountryInput.pure(countryValue ?? ''),
        state: PfStateInput.pure(stateValue ?? ''),
        city: PfCityInput.pure(cityValue ?? ''),
        village: PfVillageInput.pure(villageValue ?? ''),
        farmCapacity: PfFarmCapacityInput.pure(farmCapacityValue ?? ''),
        farm: PfFarmInput.pure(farmValue ?? ''),
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        name: PfNameInput.pure(value),
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: PfEmailInput.pure(value),
      ),
    );
  }

  void emailValidation(String email) {
    emit(
      state.copyWith(
        email: PfEmailInput.dirty(email),
        status: PersonalInfoStatus.success,
      ),
    );
  }

  void farmNameChanged(String value) {
    emit(
      state.copyWith(
        farmName: PfFarmNameInput.pure(value),
      ),
    );
  }

  void countryChanged(String value) {
    emit(
      state.copyWith(
        country: PfCountryInput.pure(value),
      ),
    );
  }

  void stateChanged(String value) {
    emit(
      state.copyWith(
        state: PfStateInput.pure(value),
      ),
    );
  }

  void cityChanged(String value) {
    emit(
      state.copyWith(
        city: PfCityInput.pure(value),
      ),
    );
  }

  void villageChanged(String value) {
    emit(
      state.copyWith(
        village: PfVillageInput.pure(value),
      ),
    );
  }

  void farmCapacityChanged(String value) {
    emit(
      state.copyWith(
        farmCapacity: PfFarmCapacityInput.pure(value),
      ),
    );
  }

  void farmChanged(String value) {
    emit(
      state.copyWith(
        farm: PfFarmInput.pure(value),
        selectedFarm: value,
      ),
    );
  }

  Future<void> changeAvatar() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);

        emit(
          state.copyWith(
            avartarImg: file,
            status: PersonalInfoStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
          status: PersonalInfoStatus.failure,
          errorMessage: S.current.errorFailedToPickImage));
    }
  }

  void savePersonalInfo() async {
    emit(state.copyWith(status: PersonalInfoStatus.loading));
    try {
      final user = PfUserModel(
        uid: FirebaseAuth.instance.currentUser?.uid ?? '',
        name: state.name.value,
        email: state.email.value,
        farmName: state.farmName.value,
        country: state.country.value,
        state: state.state.value,
        city: state.city.value,
        village: state.village.value,
        farmCapacity: state.farmCapacity.value,
        farmType: state.farm.value,
        avatarUrl: state.avartarImg?.path,
      );
      await _authRepository.updateUserData(
        user: user,
        avatar: state.avartarImg,
      );
      emit(
        state.copyWith(
          status: PersonalInfoStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: PersonalInfoStatus.failure,
          errorMessage: S.current.errorFailedToUpdateUserInfo));
    }
  }

  Future<List<PfDropdownSearchItem<String>>> loadFarmTypes() async {
    emit(state.copyWith(status: PersonalInfoStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 3000));
      final farmType = List.generate(
        6,
        (i) => 'Farm Type $i',
      );
      final result = state.farmTypes.isEmpty
          ? farmType
          : [...state.farmTypes, ...farmType];
      emit(state.copyWith(
        status: PersonalInfoStatus.success,
        farmTypes: result,
      ));
      return result
          .map(
            (type) => PfDropdownSearchItem<String>(
              label: type,
              value: type,
            ),
          )
          .toList();
    } catch (e) {
      emit(state.copyWith(
        status: PersonalInfoStatus.failure,
        errorMessage: e.toString(),
      ));
      return state.farmTypes
          .map(
            (type) => PfDropdownSearchItem<String>(
              label: type,
              value: type,
            ),
          )
          .toList();
    }
  }
}

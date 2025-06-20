import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poltry_farm/repositories/auth_repository.dart';
import 'package:poltry_farm/resources/l10n_generated/l10n.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/widgets/dropdown.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(PersonalInfoState.initial());

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
        nameForm: state.nameForm.copyWith(
          text: nameValue,
        ),
        emailForm: state.emailForm.copyWith(
          text: emailValue,
        ),
        farmNameForm: state.farmNameForm.copyWith(
          text: farmNameValue,
        ),
        countryForm: state.countryForm.copyWith(
          text: countryValue,
        ),
        stateForm: state.stateForm.copyWith(
          text: stateValue,
        ),
        cityForm: state.cityForm.copyWith(
          text: cityValue,
        ),
        villageForm: state.villageForm.copyWith(
          text: villageValue,
        ),
        farmCapacityForm: state.farmCapacityForm.copyWith(
          text: farmCapacityValue,
        ),
        farmForm: state.farmForm.copyWith(
          selectedItem: farmValue,
          text: farmValue,
        ),
      ),
    );
  }

  void nameFormChanged(String? value) {
    emit(
      state.copyWith(
        nameForm: state.nameForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void emailFormChanged(String? value) {
    emit(
      state.copyWith(
        emailForm: state.emailForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void farmNameFormChanged(String? value) {
    emit(
      state.copyWith(
        farmNameForm: state.farmNameForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void countryFormChanged(String? value) {
    emit(
      state.copyWith(
        countryForm: state.countryForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void stateFormChanged(String? value) {
    emit(
      state.copyWith(
        stateForm: state.stateForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void cityFormChanged(String? value) {
    emit(
      state.copyWith(
        cityForm: state.cityForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void villageFormChanged(String? value) {
    emit(
      state.copyWith(
        villageForm: state.villageForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void farmCapacityFormChanged(String? value) {
    emit(
      state.copyWith(
        farmCapacityForm: state.farmCapacityForm.copyWith(
          text: value,
        ),
      ),
    );
  }

  void farmFormChanged(String? value) {
    emit(
      state.copyWith(
        farmForm: state.farmForm.copyWith(
          text: value,
          selectedItem: value,
        ),
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
        name: state.nameForm.text,
        email: state.emailForm.text,
        farmName: state.farmNameForm.text,
        country: state.countryForm.text,
        state: state.stateForm.text,
        city: state.cityForm.text,
        village: state.villageForm.text,
        farmCapacity: state.farmCapacityForm.text,
        farmType: state.farmForm.selectedItem,
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
      await Future.delayed(const Duration(milliseconds: 500));
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

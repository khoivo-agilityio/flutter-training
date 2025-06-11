import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poltry_farm/shared/form_models.dart';
import 'package:poltry_farm/widgets/dropdown.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoState.initial());

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
        ),
      ),
    );
  }

  void savePersonalInfo() {}

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

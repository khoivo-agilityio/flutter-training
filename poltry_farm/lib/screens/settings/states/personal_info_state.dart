part of 'personal_info_cubit.dart';

enum PersonalInfoStatus { initial, loading, success, failure }

class PersonalInfoState extends Equatable {
  final PersonalInfoStatus status;
  final String? errorMessage;

  final PfPlainTextFormFieldSubState nameForm;
  final PfPlainTextFormFieldSubState emailForm;
  final PfPlainTextFormFieldSubState farmNameForm;
  final PfPlainTextFormFieldSubState countryForm;
  final PfPlainTextFormFieldSubState stateForm;
  final PfPlainTextFormFieldSubState cityForm;
  final PfPlainTextFormFieldSubState villageForm;
  final PfPlainTextFormFieldSubState farmCapacityForm;
  final PfDropdownFormFieldSubState farmForm;
  final List<String> farmTypes;
  final File? avartarImg;

  const PersonalInfoState({
    this.status = PersonalInfoStatus.initial,
    required this.nameForm,
    required this.emailForm,
    required this.farmNameForm,
    required this.countryForm,
    required this.stateForm,
    required this.cityForm,
    required this.villageForm,
    required this.farmCapacityForm,
    required this.farmForm,
    this.farmTypes = const [],
    this.errorMessage,
    this.avartarImg,
  });

  PersonalInfoState copyWith({
    PersonalInfoStatus? status,
    String? errorMessage,
    PfPlainTextFormFieldSubState? nameForm,
    PfPlainTextFormFieldSubState? emailForm,
    PfPlainTextFormFieldSubState? farmNameForm,
    PfPlainTextFormFieldSubState? countryForm,
    PfPlainTextFormFieldSubState? stateForm,
    PfPlainTextFormFieldSubState? cityForm,
    PfPlainTextFormFieldSubState? villageForm,
    PfPlainTextFormFieldSubState? farmCapacityForm,
    PfDropdownFormFieldSubState? farmForm,
    List<String>? farmTypes,
    File? avartarImg,
  }) {
    return PersonalInfoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      nameForm: nameForm ?? this.nameForm,
      emailForm: emailForm ?? this.emailForm,
      farmNameForm: farmNameForm ?? this.farmNameForm,
      countryForm: countryForm ?? this.countryForm,
      stateForm: stateForm ?? this.stateForm,
      cityForm: cityForm ?? this.cityForm,
      villageForm: villageForm ?? this.villageForm,
      farmCapacityForm: farmCapacityForm ?? this.farmCapacityForm,
      farmForm: farmForm ?? this.farmForm,
      farmTypes: farmTypes ?? this.farmTypes,
      avartarImg: avartarImg ?? this.avartarImg,
    );
  }

  factory PersonalInfoState.initial() {
    return PersonalInfoState(
      status: PersonalInfoStatus.initial,
      nameForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formNameSemanticLabel,
        label: S.current.formNameLabel,
        hintText: S.current.formNameHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      emailForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formEmailSemanticLabel,
        label: S.current.formEmailLabel,
        hintText: S.current.formEmailHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmNameForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formFarmNameSemanticLabel,
        label: S.current.formFarmNameLabel,
        hintText: S.current.formFarmNameHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      countryForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formCountrySemanticLabel,
        label: S.current.formCountryLabel,
        hintText: S.current.formCountryHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      stateForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formStateSemanticLabel,
        label: S.current.formStateLabel,
        hintText: S.current.formStateHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      cityForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formCitySemanticLabel,
        label: S.current.formCityLabel,
        hintText: S.current.formCityHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      villageForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formVillageSemanticLabel,
        label: S.current.formVillageLabel,
        hintText: S.current.formVillageHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmCapacityForm: PfPlainTextFormFieldSubState(
        semanticsLabel: S.current.formFarmCapacitySemanticLabel,
        label: S.current.formFarmCapacityLabel,
        hintText: S.current.formFarmCapacityHint,
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmForm: PfDropdownFormFieldSubState(
        semanticsLabel: S.current.formFarmSemanticLabel,
        label: S.current.formFarmLabel,
        hintText: S.current.formFarmHint,
        items: const [],
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmTypes: const [],
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        nameForm,
        emailForm,
        farmNameForm,
        countryForm,
        stateForm,
        cityForm,
        villageForm,
        farmCapacityForm,
        farmForm,
        farmTypes,
        avartarImg,
      ];
}

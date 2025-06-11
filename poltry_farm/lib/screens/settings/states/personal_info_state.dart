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
    );
  }

  factory PersonalInfoState.initial() {
    return PersonalInfoState(
      status: PersonalInfoStatus.initial,
      nameForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'Name',
        label: 'Name',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      emailForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'email',
        label: 'Email',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmNameForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'Farm Name',
        label: 'Farm Name',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      countryForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'Country',
        label: 'Country',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      stateForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'State',
        label: 'State',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      cityForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'City',
        label: 'City',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      villageForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'Village',
        label: 'Village',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmCapacityForm: PfPlainTextFormFieldSubState(
        semanticsLabel: 'Farm Capacity',
        label: 'Farm Capacity',
        focusNode: FocusNode(),
        text: '',
        keyboardType: TextInputType.text,
      ),
      farmForm: PfDropdownFormFieldSubState(
        semanticsLabel: 'Farm',
        label: 'Farm',
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
      ];
}

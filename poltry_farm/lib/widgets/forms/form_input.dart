import 'package:formz/formz.dart';

enum ValidationError {
  invalid,
}

class PfEmailInput extends FormzInput<String, ValidationError> {
  const PfEmailInput.pure([super.value = '']) : super.pure();

  const PfEmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  ValidationError? validator(String value) {
    return _emailRegex.hasMatch(value) ? null : ValidationError.invalid;
  }
}

class PfPasswordInput extends FormzInput<String, ValidationError> {
  const PfPasswordInput.pure([super.value = '']) : super.pure();

  const PfPasswordInput.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~^%+=()\-_])[A-Za-z\d!@#\$&*~^%+=()\-_]{8,}$',
  );

  @override
  ValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : ValidationError.invalid;
  }
}

class PfNameInput extends FormzInput<String, ValidationError> {
  const PfNameInput.pure([super.value = '']) : super.pure();

  const PfNameInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfFarmNameInput extends FormzInput<String, ValidationError> {
  const PfFarmNameInput.pure([super.value = '']) : super.pure();

  const PfFarmNameInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfCountryInput extends FormzInput<String, ValidationError> {
  const PfCountryInput.pure([super.value = '']) : super.pure();

  const PfCountryInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfStateInput extends FormzInput<String, ValidationError> {
  const PfStateInput.pure([super.value = '']) : super.pure();

  const PfStateInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfCityInput extends FormzInput<String, ValidationError> {
  const PfCityInput.pure([super.value = '']) : super.pure();

  const PfCityInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfVillageInput extends FormzInput<String, ValidationError> {
  const PfVillageInput.pure([super.value = '']) : super.pure();

  const PfVillageInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfFarmCapacityInput extends FormzInput<String, ValidationError> {
  const PfFarmCapacityInput.pure([super.value = '']) : super.pure();

  const PfFarmCapacityInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

class PfFarmInput extends FormzInput<String, ValidationError> {
  const PfFarmInput.pure([super.value = '']) : super.pure();

  const PfFarmInput.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    return null;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/widgets/form_input.dart';
import '../constant.dart';

void main() {
  group('PfEmailInput', () {
    test('''Scenario: Validate email input
    Given a valid email
    When PfEmailInput.dirty is called
    Then it should pass validation''', () {
      expect(const PfEmailInput.dirty(validEmail).error, isNull);
    });

    test('''Scenario: Validate email input
    Given an invalid email
    When PfEmailInput.dirty is called
    Then it should fail validation''', () {
      expect(const PfEmailInput.dirty(invalidEmail).error,
          ValidationError.invalid);
    });
  });

  group('PfPasswordInput', () {
    test('''Scenario: Validate password input
    Given a valid password
    When PfPasswordInput.dirty is called
    Then it should pass validation''', () {
      expect(const PfPasswordInput.dirty(validPassword).error, isNull);
    });

    test(
        '''Scenario: Validate password input\nGiven an invalid password\nWhen PfPasswordInput.dirty is called\nThen it should fail validation''',
        () {
      expect(const PfPasswordInput.dirty(invalidPassword).error,
          ValidationError.invalid);
    });
  });

  final formzFields = {
    'PfNameInput': () => const PfNameInput.dirty('Name'),
    'PfFarmNameInput': () => const PfFarmNameInput.dirty('Farm'),
    'PfCountryInput': () => const PfCountryInput.dirty('Country'),
    'PfStateInput': () => const PfStateInput.dirty('State'),
    'PfCityInput': () => const PfCityInput.dirty('City'),
    'PfVillageInput': () => const PfVillageInput.dirty('Village'),
    'PfFarmCapacityInput': () => const PfFarmCapacityInput.dirty('1000'),
    'PfFarmInput': () => const PfFarmInput.dirty('Farm Info'),
    'PfProducts': () => const PfProducts.dirty('Eggs'),
  };

  formzFields.forEach((name, fieldFactory) {
    group(name, () {
      test('''Scenario: Validate $name
          Given a pure field
          When the field is created
          Then it should be valid by default''', () {
        final field = fieldFactory();
        expect(field.error, isNull);
      });
    });
  });
}

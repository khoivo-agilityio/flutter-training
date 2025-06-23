import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/widgets/forms/form_input.dart';

void main() {
  group('PfEmailInput', () {
    test('valid email passes validation', () {
      expect(const PfEmailInput.dirty('test@example.com').error, isNull);
    });

    test('invalid email fails validation', () {
      expect(const PfEmailInput.dirty('invalid_email').error,
          ValidationError.invalid);
    });
  });

  group('PfPasswordInput', () {
    test('valid password passes validation', () {
      expect(const PfPasswordInput.dirty('Abc12345!').error, isNull);
    });

    test('invalid password fails validation', () {
      expect(const PfPasswordInput.dirty('123').error, ValidationError.invalid);
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
      test('pure is valid by default', () {
        final field = fieldFactory();
        expect(field.error, isNull);
      });
    });
  });
}

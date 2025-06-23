import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/category_models.dart';

void main() {
  group('PfCategoryModel', () {
    const model = PfCategoryModel(
      name: 'Eggs',
      description: 'Fresh farm eggs',
      imageUrl: 'https://example.com/eggs.jpg',
    );

    test('supports value equality', () {
      const model2 = PfCategoryModel(
        name: 'Eggs',
        description: 'Fresh farm eggs',
        imageUrl: 'https://example.com/eggs.jpg',
      );
      expect(model, equals(model2));
    });

    test('fromJson creates correct object', () {
      final json = {
        'name': 'Eggs',
        'description': 'Fresh farm eggs',
        'imageUrl': 'https://example.com/eggs.jpg',
      };
      final result = PfCategoryModel.fromJson(json);
      expect(result, equals(model));
    });

    test('toJson returns correct map', () {
      final json = model.toJson();
      expect(json, {
        'name': 'Eggs',
        'description': 'Fresh farm eggs',
        'imageUrl': 'https://example.com/eggs.jpg',
      });
    });

    test('copyWith returns updated object', () {
      final updated = model.copyWith(name: 'Chicken');
      expect(updated.name, 'Chicken');
      expect(updated.description, model.description);
      expect(updated.imageUrl, model.imageUrl);
    });

    test('copyWith with no params returns same object', () {
      final copied = model.copyWith();
      expect(copied, equals(model));
    });
  });
}

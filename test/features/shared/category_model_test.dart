import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/category_models.dart';

void main() {
  group('PfCategoryModel', () {
    const name = 'Eggs';
    const description = 'Fresh farm eggs';
    const imageUrl = 'https://example.com/eggs.jpg';
    const model = PfCategoryModel(
      name: name,
      description: description,
      imageUrl: imageUrl,
    );

    test('supports value equality', () {
      const model2 = PfCategoryModel(
        name: name,
        description: description,
        imageUrl: imageUrl,
      );
      expect(model, equals(model2));
    });

    test('fromJson creates correct object', () {
      final json = {
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };
      final result = PfCategoryModel.fromJson(json);
      expect(result, equals(model));
    });

    test('toJson returns correct map', () {
      final json = model.toJson();
      expect(json, {
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      });
    });

    test('copyWith returns updated object', () {
      const newName = 'Chicken';
      final updated = model.copyWith(name: newName);
      expect(updated.name, newName);
      expect(updated.description, model.description);
      expect(updated.imageUrl, model.imageUrl);
    });

    test('copyWith with no params returns same object', () {
      final copied = model.copyWith();
      expect(copied, equals(model));
    });
  });
}

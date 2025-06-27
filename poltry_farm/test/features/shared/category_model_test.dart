import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/category_models.dart';
import '../constant.dart';

void main() {
  group('PfCategoryModel', () {
    const model = PfCategoryModel(
      name: testCategoryName,
      description: testCategoryDescription,
      imageUrl: testCategoryImageUrl,
    );

    test('''Scenario: Value equality
Given two identical PfCategoryModel objects
When compared using equals
Then they should be equal''', () {
      const model2 = PfCategoryModel(
        name: testCategoryName,
        description: testCategoryDescription,
        imageUrl: testCategoryImageUrl,
      );
      expect(model, equals(model2));
    });

    test('''Scenario: fromJson factory
Given a valid JSON map
When PfCategoryModel.fromJson is called
Then it should create the correct object''', () {
      final json = {
        'name': testCategoryName,
        'description': testCategoryDescription,
        'imageUrl': testCategoryImageUrl,
      };
      final result = PfCategoryModel.fromJson(json);
      expect(result, equals(model));
    });

    test('''Scenario: toJson method
Given a PfCategoryModel object
When toJson is called
Then it should return the correct map''', () {
      final json = model.toJson();
      expect(json, {
        'name': testCategoryName,
        'description': testCategoryDescription,
        'imageUrl': testCategoryImageUrl,
      });
    });

    test('''Scenario: copyWith method with new value
Given a PfCategoryModel object
When copyWith is called with a new name
Then it should return an updated object with the new name''', () {
      const newName = 'Chicken';
      final updated = model.copyWith(name: newName);
      expect(updated.name, newName);
      expect(updated.description, model.description);
      expect(updated.imageUrl, model.imageUrl);
    });

    test('''Scenario: copyWith method with no params
Given a PfCategoryModel object
When copyWith is called with no parameters
Then it should return the same object''', () {
      final copied = model.copyWith();
      expect(copied, equals(model));
    });
  });
}

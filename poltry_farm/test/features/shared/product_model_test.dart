import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/product_models.dart';
import '../constant.dart';

void main() {
  group('PfProductModel', () {
    const model = PfProductModel(
      name: testProductName,
      description: testProductDescription,
      price: testProductPrice,
      imageUrl: testProductImageUrl,
      quantity: testProductQuantity,
      location: testProductLocation,
    );

    test('''Scenario: Value equality
        Given two identical PfProductModel objects
        When compared using equals
        Then they should be equal''', () {
      const model2 = PfProductModel(
        name: testProductName,
        description: testProductDescription,
        price: testProductPrice,
        imageUrl: testProductImageUrl,
        quantity: testProductQuantity,
        location: testProductLocation,
      );
      expect(model, equals(model2));
    });

    test('''Scenario: fromJson factory
        Given a valid JSON map
        When PfProductModel.fromJson is called
        Then it should create the correct object''', () {
      final json = {
        'name': testProductName,
        'description': testProductDescription,
        'price': testProductPrice,
        'imageUrl': testProductImageUrl,
        'quantity': testProductQuantity,
        'location': testProductLocation,
      };
      final result = PfProductModel.fromJson(json);
      expect(result, model);
    });

    test('''Scenario: toJson method
        Given a PfProductModel object
        When toJson is called
        Then it should return the correct map''', () {
      final json = model.toJson();
      expect(json, {
        'name': testProductName,
        'description': testProductDescription,
        'price': testProductPrice,
        'imageUrl': testProductImageUrl,
        'quantity': testProductQuantity,
        'location': testProductLocation,
      });
    });

    test('''Scenario: copyWith method with new values
        Given a PfProductModel object
        When copyWith is called with new values
        Then it should return an updated object with the new values''', () {
      const newName = 'Duck Feed';
      const newPrice = 60.0;
      const newQuantity = 50;
      final updated = model.copyWith(
        name: newName,
        price: newPrice,
        quantity: newQuantity,
      );
      expect(updated.name, newName);
      expect(updated.price, newPrice);
      expect(updated.quantity, newQuantity);
      expect(updated.description, model.description);
      expect(updated.imageUrl, model.imageUrl);
      expect(updated.location, model.location);
    });

    test('''Scenario: copyWith method with no params
        Given a PfProductModel object
        When copyWith is called with no parameters
        Then it should return the same object''', () {
      final copied = model.copyWith();
      expect(copied, equals(model));
    });
  });
}

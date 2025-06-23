import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/product_models.dart';

void main() {
  group('PfProductModel', () {
    const model = PfProductModel(
      name: 'Chicken Feed',
      description: 'High quality feed',
      price: 50.5,
      imageUrl: 'https://example.com/feed.jpg',
      quantity: 100,
      location: 'Storage A',
    );

    test('supports value equality', () {
      const model2 = PfProductModel(
        name: 'Chicken Feed',
        description: 'High quality feed',
        price: 50.5,
        imageUrl: 'https://example.com/feed.jpg',
        quantity: 100,
        location: 'Storage A',
      );
      expect(model, equals(model2));
    });

    test('fromJson returns correct model', () {
      final json = {
        'name': 'Chicken Feed',
        'description': 'High quality feed',
        'price': 50.5,
        'imageUrl': 'https://example.com/feed.jpg',
        'quantity': 100,
        'location': 'Storage A',
      };

      final result = PfProductModel.fromJson(json);

      expect(result, model);
    });

    test('toJson returns correct map', () {
      final json = model.toJson();

      expect(json, {
        'name': 'Chicken Feed',
        'description': 'High quality feed',
        'price': 50.5,
        'imageUrl': 'https://example.com/feed.jpg',
        'quantity': 100,
        'location': 'Storage A',
      });
    });

    test('copyWith returns updated model', () {
      final updated = model.copyWith(
        name: 'Duck Feed',
        price: 60.0,
        quantity: 50,
      );

      expect(updated.name, 'Duck Feed');
      expect(updated.price, 60.0);
      expect(updated.quantity, 50);
      expect(updated.description, model.description);
      expect(updated.imageUrl, model.imageUrl);
      expect(updated.location, model.location);
    });

    test('copyWith with no params returns same model', () {
      final copied = model.copyWith();

      expect(copied, equals(model));
    });
  });
}

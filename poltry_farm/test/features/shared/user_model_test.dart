import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

void main() {
  group('PfUserModel', () {
    const testUser = PfUserModel(
      uid: '123',
      name: 'John Doe',
      email: 'john@example.com',
      farmName: 'Happy Farm',
      country: 'Vietnam',
      state: 'Central',
      city: 'Danang',
      village: 'Hoa Tien',
      farmCapacity: '1000',
      farmType: 'Chicken',
      avatarUrl: 'https://example.com/avatar.jpg',
      fcmToken: 'fcm_test_token',
    );

    test('toMap returns correct map', () {
      final map = testUser.toMap();
      expect(map, {
        'uid': '123',
        'name': 'John Doe',
        'email': 'john@example.com',
        'farmName': 'Happy Farm',
        'country': 'Vietnam',
        'state': 'Central',
        'city': 'Danang',
        'village': 'Hoa Tien',
        'farmCapacity': '1000',
        'farmType': 'Chicken',
        'avatarUrl': 'https://example.com/avatar.jpg',
        'fcmToken': 'fcm_test_token',
      });
    });

    test('copyWith updates fields correctly', () {
      final updated = testUser.copyWith(
        name: 'Jane Doe',
        city: 'Hue',
      );

      expect(updated.name, 'Jane Doe');
      expect(updated.city, 'Hue');
      expect(updated.email, testUser.email); // unchanged
    });

    test('fromDB returns correct model', () {
      final dbModel = UserDbModel(
        uid: '123',
        name: 'John Doe',
        email: 'john@example.com',
        farmName: 'Happy Farm',
        country: 'Vietnam',
        state: 'Central',
        city: 'Danang',
        village: 'Hoa Tien',
        farmCapacity: '1000',
        farmType: 'Chicken',
        avatarUrl: 'https://example.com/avatar.jpg',
        fcmToken: 'fcm_test_token',
      );

      final model = PfUserModel.fromDB(dbModel);

      expect(model.name, 'John Doe');
      expect(model.city, 'Danang');
    });

    // test('fromFirestore returns correct model', () {
    //   final mockDoc = MockDocumentSnapshot();

    //   when(mockDoc.id).thenReturn('123');
    //   when(mockDoc.data()).thenReturn({
    //     'name': 'John Doe',
    //     'email': 'john@example.com',
    //     'farmName': 'Happy Farm',
    //     'country': 'Vietnam',
    //     'state': 'Central',
    //     'city': 'Danang',
    //     'village': 'Hoa Tien',
    //     'farmCapacity': '1000',
    //     'farmType': 'Chicken',
    //     'avatarUrl': 'https://example.com/avatar.jpg',
    //     'fcmToken': 'fcm_test_token',
    //   });

    //   final model = PfUserModel.fromFirestore(mockDoc);

    //   expect(model.uid, '123');
    //   expect(model.email, 'john@example.com');
    //   expect(model.city, 'Danang');
    // });

    test('empty user has all empty fields', () {
      const empty = PfUserModel.empty;

      expect(empty.uid, '');
      expect(empty.email, '');
      expect(empty.name, '');
      expect(empty.farmCapacity, '');
    });
  });
}

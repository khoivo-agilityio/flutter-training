import 'package:flutter_test/flutter_test.dart';
import 'package:poltry_farm/shared/user_model.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

void main() {
  group('PfUserModel', () {
    const uid = '123';
    const name = 'John Doe';
    const email = 'john@example.com';
    const farmName = 'Happy Farm';
    const country = 'Vietnam';
    const state = 'Central';
    const city = 'Danang';
    const village = 'Hoa Tien';
    const farmCapacity = '1000';
    const farmType = 'Chicken';
    const avatarUrl = 'https://example.com/avatar.jpg';
    const fcmToken = 'fcm_test_token';
    const testUser = PfUserModel(
      uid: uid,
      name: name,
      email: email,
      farmName: farmName,
      country: country,
      state: state,
      city: city,
      village: village,
      farmCapacity: farmCapacity,
      farmType: farmType,
      avatarUrl: avatarUrl,
      fcmToken: fcmToken,
    );

    test('''Scenario: toMap method
    Given a PfUserModel object
    When toMap is called
    Then it should return the correct map''', () {
      final map = testUser.toMap();
      expect(map, {
        'uid': uid,
        'name': name,
        'email': email,
        'farmName': farmName,
        'country': country,
        'state': state,
        'city': city,
        'village': village,
        'farmCapacity': farmCapacity,
        'farmType': farmType,
        'avatarUrl': avatarUrl,
        'fcmToken': fcmToken,
      });
    });

    test('''Scenario: copyWith method
    Given a PfUserModel object
    When copyWith is called with new values
    Then it should return an updated object with the new values''', () {
      const newName = 'Jane Doe';
      const newCity = 'Hue';
      final updated = testUser.copyWith(
        name: newName,
        city: newCity,
      );
      expect(updated.name, newName);
      expect(updated.city, newCity);
      expect(updated.email, testUser.email); // unchanged
    });

    test('''Scenario: fromDB factory
    Given a UserDbModel object
    When PfUserModel.fromDB is called
    Then it should create the correct PfUserModel object''', () {
      final dbModel = UserDbModel(
        uid: uid,
        name: name,
        email: email,
        farmName: farmName,
        country: country,
        state: state,
        city: city,
        village: village,
        farmCapacity: farmCapacity,
        farmType: farmType,
        avatarUrl: avatarUrl,
        fcmToken: fcmToken,
      );
      final model = PfUserModel.fromDB(dbModel);
      expect(model.name, name);
      expect(model.city, city);
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

    test('''Scenario: empty user
    Given PfUserModel.empty
    When checking its fields
    Then all fields should be empty strings''', () {
      const empty = PfUserModel.empty;
      expect(empty.uid, '');
      expect(empty.email, '');
      expect(empty.name, '');
      expect(empty.farmCapacity, '');
    });
  });
}

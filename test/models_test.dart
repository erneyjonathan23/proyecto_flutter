import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto/models/user.dart';
import 'package:proyecto/models/address.dart' as address_model;

void main() {
  group('User Model', () {
    test('User creation and copyWith', () {
      final address = address_model.Address(
        country: 'Colombia',
        department: 'Antioquia',
        city: 'Medellín',
        details: 'Carrera 70 #C9-20, Apto 502',
      );
      final user = User(
        firstName: 'Juan',
        lastName: 'David',
        birthDate: DateTime(1994, 1, 1),
        gender: 'Masculino',
        addresses: [address],
      );
      expect(user.firstName, 'Juan');
      expect(user.addresses.length, 1);
      final updated = user.copyWith(firstName: 'Pedro');
      expect(updated.firstName, 'Pedro');
      expect(updated.lastName, 'David');
    });
  });

  group('Address Model', () {
    test('Address creation', () {
      final address = address_model.Address(
        country: 'Colombia',
        department: 'Antioquia',
        city: 'Medellín',
        details: 'Carrera 70 #C9-20, Apto 502',
      );
      expect(address.city, 'Medellín');
      expect(address.details, contains('Apto 502'));
    });
  });
}

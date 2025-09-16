import 'address.dart';

class User {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final List<Address> addresses;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    this.addresses = const [],
  });

  User copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? gender,
    List<Address>? addresses,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      addresses: addresses ?? this.addresses,
    );
  }
}

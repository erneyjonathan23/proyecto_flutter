import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/address.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void createUser({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String gender,
  }) {
    _user = User(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      addresses: [],
    );
    notifyListeners();
  }

  void addAddress(Address address) {
    if (_user != null) {
      _user = _user!.copyWith(
        addresses: List.from(_user!.addresses)..add(address),
      );
      notifyListeners();
    }
  }

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}

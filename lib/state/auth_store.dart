import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../models/user_account.dart';
import '../storage/app_storage.dart';

class AuthStore extends ChangeNotifier {
  AuthStore(this._storage);

  static const _usersKey = 'lumen.users';
  static const _sessionKey = 'lumen.sessionEmail';

  final AppStorage _storage;
  final List<UserAccount> _users = [];
  UserAccount? _currentUser;

  UserAccount? get currentUser => _currentUser;

  Future<void> load() async {
    _users
      ..clear()
      ..addAll(_readUsers());
    final sessionEmail = _storage.getString(_sessionKey);
    if (sessionEmail != null) {
      _currentUser = _findByEmail(sessionEmail);
    }
    notifyListeners();
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalized = email.trim().toLowerCase();
    if (_findByEmail(normalized) != null) {
      return 'Este e-mail já está cadastrado.';
    }
    final user = UserAccount(
      name: name.trim(),
      email: normalized,
      passwordHash: _hash(password),
    );
    _users.add(user);
    await _storage.setString(
      _usersKey,
      jsonEncode(_users.map((item) => item.toJson()).toList()),
    );
    _currentUser = user;
    await _storage.setString(_sessionKey, user.email);
    notifyListeners();
    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final user = _findByEmail(email.trim().toLowerCase());
    if (user == null) {
      return 'Não encontramos uma conta com este e-mail.';
    }
    if (user.passwordHash != _hash(password)) {
      return 'Senha incorreta.';
    }
    _currentUser = user;
    await _storage.setString(_sessionKey, user.email);
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.remove(_sessionKey);
    notifyListeners();
  }

  List<UserAccount> _readUsers() {
    final raw = _storage.getString(_usersKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => UserAccount.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  UserAccount? _findByEmail(String email) {
    for (final user in _users) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  String _hash(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}

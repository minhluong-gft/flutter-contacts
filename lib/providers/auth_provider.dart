import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/models/auth_state.dart';
import 'package:flutter_contacts/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

const kKeyCredentials = 'credentials';

@Riverpod(keepAlive: true)
class Auth extends _$Auth implements Listenable {
  VoidCallback? _routerListener;

  @override
  AuthState build() {
    checkIfAuthenticated();
    return const AuthStateInitial();
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }

  Future<void> checkIfAuthenticated() async {
    state = const AuthStateAuthenticating();
    String? credentials =
        await ref.read(secureStorageProvider).read(key: kKeyCredentials);

    final isAuthenticated = credentials != null;

    if (isAuthenticated) {
      state = AuthStateAuthenticated(credentials: credentials);
    } else {
      state = const AuthStateUnauthenticated();
    }

    _routerListener?.call();
  }

  String? redirect(GoRouterState goRouterState) {
    final isAuthenticating = switch (state) {
      AuthStateInitial() || AuthStateAuthenticating() => true,
      _ => false,
    };
    if (isAuthenticating) {
      return null;
    }
    final isAuthenticated = state is AuthStateAuthenticated;
    final isAtLoginPage = goRouterState.matchedLocation == '/login';

    if (isAtLoginPage) {
      return isAuthenticated ? '/contacts' : null;
    } else {
      return isAuthenticated ? null : '/login';
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final credentials = await ref
        .read(authRepositoryProvider)
        .login(username: username, password: password);

    await ref
        .read(secureStorageProvider)
        .write(key: kKeyCredentials, value: credentials);

    state =
        AuthStateAuthenticated(username: username, credentials: credentials);

    _routerListener?.call();
  }

  void logout() async {
    ref.read(secureStorageProvider).delete(key: kKeyCredentials);
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }
}

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

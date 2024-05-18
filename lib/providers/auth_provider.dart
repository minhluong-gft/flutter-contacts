import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as proto;
import 'package:flutter_contacts/models/auth_state.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

const storage = FlutterSecureStorage();
const kKeyCredentials = 'credentials';

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> implements Listenable {
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
    String? credentials = await storage.read(key: kKeyCredentials);
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
    final isAuthenticated = state == const AuthStateAuthenticated();
    final isAtLoginPage = goRouterState.matchedLocation == '/login';

    if (isAtLoginPage) {
      return isAuthenticated ? '/contacts' : null;
    } else {
      return isAuthenticated ? null : '/login';
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final response = await ContactsService.instance.client
        .login(proto.LoginRequest(username: username, password: password));

    await storage.write(key: kKeyCredentials, value: response.credentials);

    state = AuthStateAuthenticated(
        username: username, credentials: response.credentials);

    _routerListener?.call();
  }

  void logout() async {
    storage.delete(key: kKeyCredentials);
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }
}

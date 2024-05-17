import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as proto;
import 'package:flutter_contacts/models/auth_state.dart';
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    await Future.delayed(const Duration(microseconds: 500));
    const isAuthenticated = 1 != 1;

    if (isAuthenticated) {
      state = const AuthStateAuthenticated();
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

    state = AuthStateAuthenticated(
        username: username, credentials: response.credentials);

    _routerListener?.call();
  }

  void logout() {
    state = const AuthStateUnauthenticated();
    _routerListener?.call();
  }
}

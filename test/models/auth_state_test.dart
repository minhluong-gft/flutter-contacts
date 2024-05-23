import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contacts/models/auth_state.dart'; // Adjust the import to your actual file location

void main() {
  group('AuthState', () {
    test('AuthStateInitial supports value comparison', () {
      expect(const AuthStateInitial(), const AuthStateInitial());
      expect(const AuthStateInitial().props, const <Object?>[]);
    });

    test('AuthStateAuthenticated supports value comparison', () {
      const authState1 =
          AuthStateAuthenticated(username: 'user', credentials: 'pass');
      const authState2 =
          AuthStateAuthenticated(username: 'user', credentials: 'pass');
      const authState3 = AuthStateAuthenticated(
          username: 'differentUser', credentials: 'pass');

      expect(authState1, authState2);
      expect(authState1, isNot(authState3));
    });

    test('AuthStateAuthenticating supports value comparison', () {
      expect(const AuthStateAuthenticating(), const AuthStateAuthenticating());
      expect(const AuthStateAuthenticating().props, const <Object?>[]);
    });

    test('AuthStateUnauthenticated supports value comparison', () {
      expect(
          const AuthStateUnauthenticated(), const AuthStateUnauthenticated());
      expect(const AuthStateUnauthenticated().props, const <Object?>[]);
    });

    test('AuthStateAuthenticated correctly assigns properties', () {
      const username = 'testUser';
      const credentials = 'testPass';
      const authState =
          AuthStateAuthenticated(username: username, credentials: credentials);

      expect(authState.username, username);
      expect(authState.credentials, credentials);
    });
  });
}

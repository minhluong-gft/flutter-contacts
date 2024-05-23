import 'package:flutter_contacts/models/auth_state.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_contacts/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../create_container.dart';

import 'auth_provider_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<AuthRepository>(), MockSpec<FlutterSecureStorage>()])
void main() {
  group('AuthProviders', () {
    test('login', () async {
      final mockAuthRepository = MockAuthRepository();
      final mockFlutterSecureStorage = MockFlutterSecureStorage();
      final container = createContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          secureStorageProvider.overrideWithValue(mockFlutterSecureStorage),
        ],
      );

      expect(container.read(authProvider), equals(const AuthStateInitial()));

      when(mockAuthRepository.login(
              username: 'test-user', password: 'test-password'))
          .thenAnswer((_) => Future.value('test-credentials'));

      await container
          .read(authProvider.notifier)
          .login(username: 'test-user', password: 'test-password');

      verify(mockAuthRepository.login(
              username: 'test-user', password: 'test-password'))
          .called(1);

      verify(mockFlutterSecureStorage.write(
              key: kKeyCredentials, value: 'test-credentials'))
          .called(1);

      expectLater(
          container.read(authProvider),
          const AuthStateAuthenticated(
              username: 'test-user', credentials: 'test-credentials'));
    });
  });
}

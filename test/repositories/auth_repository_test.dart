import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;
import 'package:flutter_contacts/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock_response_future.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([grpc.ContactsClient])
void main() {
  final mockClient = MockContactsClient();
  final repository = AuthRepository(client: mockClient);

  test('login', () async {
    final mockResponse = grpc.LoginResponse(credentials: "valid_token");

    when(mockClient
            .login(grpc.LoginRequest(username: 'user', password: 'pass')))
        .thenAnswer((_) => MockResponseFuture(mockResponse));

    expect(await repository.login(username: 'user', password: 'pass'),
        "valid_token");
  });
}

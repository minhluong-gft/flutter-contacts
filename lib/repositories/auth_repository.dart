import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;
import 'package:flutter_contacts/services/contacts_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final grpc.ContactsClient _client;

  const AuthRepository({required grpc.ContactsClient client})
      : _client = client;

  Future<String> login(
      {required String username, required String password}) async {
    final response = await _client.login(
      grpc.LoginRequest(username: username, password: password),
    );
    return response.credentials;
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    client: ContactsService.instance.client,
  );
}

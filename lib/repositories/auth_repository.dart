import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart' as grpc;

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

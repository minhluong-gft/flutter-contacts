import 'package:flutter_contacts/generated/proto/index.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ContactsService {
  static final ContactsService _instance = ContactsService._internal();
  static ContactsService get instance => _instance;

  ContactsService._internal();

  factory ContactsService() {
    return _instance;
  }

  late ContactsClient _client;
  ContactsClient get client => _client;

  Future<void> init() async {
    _createChannel();
  }

  _createChannel() {
    const host = "10.234.60.241";
    final channel = ClientChannel(
      host,
      port: 50051,
      options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectTimeout: Duration(seconds: 3)),
    );

    _client = ContactsClient(channel);
  }
}

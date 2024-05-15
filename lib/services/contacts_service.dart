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
    const host = "192.168.1.7";
    final channel = ClientChannel(
      host,
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _client = ContactsClient(channel);
  }
}
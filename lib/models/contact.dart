import 'package:flutter_contacts/generated/proto/index.pb.dart' as grpc;

class Contact {
  final String id;
  final String fullName;
  final String? avatar;
  final String email;
  final bool isFavorite;

  const Contact({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.email,
    this.isFavorite = false,
  });

  factory Contact.fromGrpcContact(grpc.Contact contact) {
    return Contact(
      id: contact.id,
      fullName: contact.fullName,
      avatar: contact.avatar,
      email: contact.email,
      isFavorite: contact.isFavorite,
    );
  }

  Contact copyWith({
    String? id,
    String? fullName,
    String? avatar,
    String? email,
    bool? isFavorite,
  }) {
    return Contact(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

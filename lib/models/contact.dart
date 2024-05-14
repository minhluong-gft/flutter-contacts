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

  Contact copyWith({bool? isFavoriteParameter}) {
    return Contact(
        id: id,
        fullName: fullName,
        avatar: avatar,
        email: email,
        isFavorite: isFavoriteParameter ?? isFavorite);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactHash() => r'364d586b1e26d309031a19271bcbc0a448ef880f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [contact].
@ProviderFor(contact)
const contactProvider = ContactFamily();

/// See also [contact].
class ContactFamily extends Family<AsyncValue<Contact>> {
  /// See also [contact].
  const ContactFamily();

  /// See also [contact].
  ContactProvider call(
    String contactId,
  ) {
    return ContactProvider(
      contactId,
    );
  }

  @override
  ContactProvider getProviderOverride(
    covariant ContactProvider provider,
  ) {
    return call(
      provider.contactId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'contactProvider';
}

/// See also [contact].
class ContactProvider extends AutoDisposeFutureProvider<Contact> {
  /// See also [contact].
  ContactProvider(
    String contactId,
  ) : this._internal(
          (ref) => contact(
            ref as ContactRef,
            contactId,
          ),
          from: contactProvider,
          name: r'contactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$contactHash,
          dependencies: ContactFamily._dependencies,
          allTransitiveDependencies: ContactFamily._allTransitiveDependencies,
          contactId: contactId,
        );

  ContactProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contactId,
  }) : super.internal();

  final String contactId;

  @override
  Override overrideWith(
    FutureOr<Contact> Function(ContactRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ContactProvider._internal(
        (ref) => create(ref as ContactRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contactId: contactId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Contact> createElement() {
    return _ContactProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContactProvider && other.contactId == contactId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contactId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ContactRef on AutoDisposeFutureProviderRef<Contact> {
  /// The parameter `contactId` of this provider.
  String get contactId;
}

class _ContactProviderElement extends AutoDisposeFutureProviderElement<Contact>
    with ContactRef {
  _ContactProviderElement(super.provider);

  @override
  String get contactId => (origin as ContactProvider).contactId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

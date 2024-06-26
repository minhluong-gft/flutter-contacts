//
//  Generated code. Do not modify.
//  source: proto/index.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = {
  '1': 'HelloRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode(
    'CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = {
  '1': 'HelloReply',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode(
    'CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use voidDescriptor instead')
const Void$json = {
  '1': 'Void',
};

/// Descriptor for `Void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voidDescriptor = $convert.base64Decode(
    'CgRWb2lk');

@$core.Deprecated('Use idDescriptor instead')
const Id$json = {
  '1': 'Id',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `Id`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idDescriptor = $convert.base64Decode(
    'CgJJZBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use contactsResponseDescriptor instead')
const ContactsResponse$json = {
  '1': 'ContactsResponse',
  '2': [
    {'1': 'contacts', '3': 1, '4': 3, '5': 11, '6': '.contactsproto.Contact', '10': 'contacts'},
  ],
};

/// Descriptor for `ContactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactsResponseDescriptor = $convert.base64Decode(
    'ChBDb250YWN0c1Jlc3BvbnNlEjIKCGNvbnRhY3RzGAEgAygLMhYuY29udGFjdHNwcm90by5Db2'
    '50YWN0Ughjb250YWN0cw==');

@$core.Deprecated('Use contactDescriptor instead')
const Contact$json = {
  '1': 'Contact',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'fullName', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'avatar', '3': 4, '4': 1, '5': 9, '10': 'avatar'},
    {'1': 'isFavorite', '3': 5, '4': 1, '5': 8, '10': 'isFavorite'},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode(
    'CgdDb250YWN0Eg4KAmlkGAEgASgJUgJpZBIaCghmdWxsTmFtZRgCIAEoCVIIZnVsbE5hbWUSFA'
    'oFZW1haWwYAyABKAlSBWVtYWlsEhYKBmF2YXRhchgEIAEoCVIGYXZhdGFyEh4KCmlzRmF2b3Jp'
    'dGUYBSABKAhSCmlzRmF2b3JpdGU=');

@$core.Deprecated('Use createContactRequestDescriptor instead')
const CreateContactRequest$json = {
  '1': 'CreateContactRequest',
  '2': [
    {'1': 'fullName', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'avatar', '3': 4, '4': 1, '5': 9, '10': 'avatar'},
  ],
};

/// Descriptor for `CreateContactRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createContactRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVDb250YWN0UmVxdWVzdBIaCghmdWxsTmFtZRgCIAEoCVIIZnVsbE5hbWUSFAoFZW'
    '1haWwYAyABKAlSBWVtYWlsEhYKBmF2YXRhchgEIAEoCVIGYXZhdGFy');

@$core.Deprecated('Use setContactFavoriteRequestDescriptor instead')
const SetContactFavoriteRequest$json = {
  '1': 'SetContactFavoriteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'isFavorite', '3': 2, '4': 1, '5': 8, '10': 'isFavorite'},
  ],
};

/// Descriptor for `SetContactFavoriteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setContactFavoriteRequestDescriptor = $convert.base64Decode(
    'ChlTZXRDb250YWN0RmF2b3JpdGVSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIeCgppc0Zhdm9yaX'
    'RlGAIgASgIUgppc0Zhdm9yaXRl');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1lEhoKCHBhc3N3b3JkGA'
    'IgASgJUghwYXNzd29yZA==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'credentials', '3': 1, '4': 1, '5': 9, '10': 'credentials'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEiAKC2NyZWRlbnRpYWxzGAEgASgJUgtjcmVkZW50aWFscw==');


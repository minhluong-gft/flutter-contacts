//
//  Generated code. Do not modify.
//  source: proto/index.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'index.pb.dart' as $0;

export 'index.pb.dart';

@$pb.GrpcServiceName('contactsproto.Contacts')
class ContactsClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/contactsproto.Contacts/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$getContacts = $grpc.ClientMethod<$0.Void, $0.ContactsResponse>(
      '/contactsproto.Contacts/GetContacts',
      ($0.Void value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ContactsResponse.fromBuffer(value));
  static final _$getContact = $grpc.ClientMethod<$0.Id, $0.Contact>(
      '/contactsproto.Contacts/GetContact',
      ($0.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Contact.fromBuffer(value));
  static final _$createContact = $grpc.ClientMethod<$0.CreateContactRequest, $0.Contact>(
      '/contactsproto.Contacts/CreateContact',
      ($0.CreateContactRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Contact.fromBuffer(value));
  static final _$deleteContact = $grpc.ClientMethod<$0.Id, $0.Void>(
      '/contactsproto.Contacts/DeleteContact',
      ($0.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Void.fromBuffer(value));
  static final _$setContactFavorite = $grpc.ClientMethod<$0.SetContactFavoriteRequest, $0.Contact>(
      '/contactsproto.Contacts/setContactFavorite',
      ($0.SetContactFavoriteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Contact.fromBuffer(value));

  ContactsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseFuture<$0.ContactsResponse> getContacts($0.Void request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContacts, request, options: options);
  }

  $grpc.ResponseFuture<$0.Contact> getContact($0.Id request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getContact, request, options: options);
  }

  $grpc.ResponseFuture<$0.Contact> createContact($0.CreateContactRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createContact, request, options: options);
  }

  $grpc.ResponseFuture<$0.Void> deleteContact($0.Id request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteContact, request, options: options);
  }

  $grpc.ResponseFuture<$0.Contact> setContactFavorite($0.SetContactFavoriteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setContactFavorite, request, options: options);
  }
}

@$pb.GrpcServiceName('contactsproto.Contacts')
abstract class ContactsServiceBase extends $grpc.Service {
  $core.String get $name => 'contactsproto.Contacts';

  ContactsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Void, $0.ContactsResponse>(
        'GetContacts',
        getContacts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Void.fromBuffer(value),
        ($0.ContactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Id, $0.Contact>(
        'GetContact',
        getContact_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Id.fromBuffer(value),
        ($0.Contact value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateContactRequest, $0.Contact>(
        'CreateContact',
        createContact_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateContactRequest.fromBuffer(value),
        ($0.Contact value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Id, $0.Void>(
        'DeleteContact',
        deleteContact_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Id.fromBuffer(value),
        ($0.Void value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetContactFavoriteRequest, $0.Contact>(
        'setContactFavorite',
        setContactFavorite_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetContactFavoriteRequest.fromBuffer(value),
        ($0.Contact value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.ContactsResponse> getContacts_Pre($grpc.ServiceCall call, $async.Future<$0.Void> request) async {
    return getContacts(call, await request);
  }

  $async.Future<$0.Contact> getContact_Pre($grpc.ServiceCall call, $async.Future<$0.Id> request) async {
    return getContact(call, await request);
  }

  $async.Future<$0.Contact> createContact_Pre($grpc.ServiceCall call, $async.Future<$0.CreateContactRequest> request) async {
    return createContact(call, await request);
  }

  $async.Future<$0.Void> deleteContact_Pre($grpc.ServiceCall call, $async.Future<$0.Id> request) async {
    return deleteContact(call, await request);
  }

  $async.Future<$0.Contact> setContactFavorite_Pre($grpc.ServiceCall call, $async.Future<$0.SetContactFavoriteRequest> request) async {
    return setContactFavorite(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello($grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.ContactsResponse> getContacts($grpc.ServiceCall call, $0.Void request);
  $async.Future<$0.Contact> getContact($grpc.ServiceCall call, $0.Id request);
  $async.Future<$0.Contact> createContact($grpc.ServiceCall call, $0.CreateContactRequest request);
  $async.Future<$0.Void> deleteContact($grpc.ServiceCall call, $0.Id request);
  $async.Future<$0.Contact> setContactFavorite($grpc.ServiceCall call, $0.SetContactFavoriteRequest request);
}

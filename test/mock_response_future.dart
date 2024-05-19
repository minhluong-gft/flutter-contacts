import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:mockito/mockito.dart';

class MockResponseFuture<T> extends Mock implements ResponseFuture<T> {
  final T value;

  MockResponseFuture(this.value);

  @override
  Future<S> then<S>(FutureOr<S> Function(T) onValue, {Function? onError}) =>
      Future.value(value).then(onValue, onError: onError);
}

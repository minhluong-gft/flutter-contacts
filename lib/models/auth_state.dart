import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  final String? username;
  final String? credentials;

  const AuthState({this.username, this.credentials});
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({super.username, super.credentials});

  @override
  List<Object?> get props => [super.username, super.credentials];
}

final class AuthStateAuthenticating extends AuthState {
  const AuthStateAuthenticating();

  @override
  List<Object?> get props => [];
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}

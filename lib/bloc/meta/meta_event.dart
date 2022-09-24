part of 'meta_bloc.dart';

@immutable
abstract class WalletConnectEvent {}

class WalletConnectConnected extends WalletConnectEvent {
  final WalletConnectSession session;
  WalletConnectConnected(this.session);
}

class WalletConnectAppLoaded extends WalletConnectEvent {}

class WalletConnectConnectionRequested extends WalletConnectEvent {}

class WalletConnectDisconnected extends WalletConnectEvent {

}
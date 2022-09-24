part of 'meta_bloc.dart';

@immutable
abstract class WalletConnectState extends Equatable {

}


//wallet initial state
class WalletConnectInitial extends WalletConnectState {

  @override
  List<Object> get props => [];
}


//wallet loading state


class WalletConnectLoading extends WalletConnectState {

  @override
  List<Object> get props => [];
}


//wallet loaded state
//props to compare the specified('wallet') values.

class WalletConnectConnectionSuccess extends WalletConnectState {
  final WalletConnectSession session;
  WalletConnectConnectionSuccess(this.session);



  @override
  List<Object> get props => [];
}


//wallet error state
//props to compare the specified('message') values.
class WalletErrorState extends WalletConnectState {
  final String message;
  WalletErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

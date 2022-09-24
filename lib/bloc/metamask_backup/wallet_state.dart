// ignore_for_file: public_member_api_docs, sort_constructors_first
part of wallet_cubit;

class WalletState extends Equatable {
   SessionStatus? session;
   String? uri;
   String? signature;
  WalletState(this.session, this.signature , this.uri);
  @override
  List<Object?> get props => [session, signature, uri];

  WalletState copyWith({
    dynamic session,
    String? signature,
    String? uri,
  }) {
    return WalletState(
      session ?? this.session,
      signature ?? this.signature,
      uri ?? this.uri,
    );
  }
}
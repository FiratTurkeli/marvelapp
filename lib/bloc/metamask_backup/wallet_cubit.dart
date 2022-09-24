 library wallet_cubit;


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  //Wallet state for super
  WalletCubit() : super(WalletState(null, null, null));
  WalletConnect? connector;
  final sessionStorage = WalletConnectSecureStorage();
  var _session, _uri, _signature;

  void initWalletConnect() async {
    final localSession = await sessionStorage.getSession();
    if (localSession != null) {
      connector = WalletConnect(
          bridge: 'https://bridge.walletconnect.org',
          sessionStorage: sessionStorage,
          session: localSession,
          clientMeta: const PeerMeta(
              name: 'Intangible',
              description: 'NFT Marketplace',
              url: 'https://intangible.org',
              icons: [
                'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
              ]));

      emit(state.copyWith(
          session: SessionStatus(
              chainId: localSession.chainId, accounts: localSession.accounts)));
    }

    connector?.on('connect', (SessionStatus session) {
      print('CONNECT $session');
      _session = session;
      emit(state.copyWith(session: _session as SessionStatus,));
    });
    connector?.on('session_update', (WCSessionUpdateResponse payload) {
      _session = payload;

      emit(state.copyWith(
          session: SessionStatus(
              chainId: payload.chainId, accounts: payload.accounts)));
    });
    connector?.on('disconnect', (payload) {
      _session = null;
      emit(state.copyWith(session: _session as SessionStatus));
    });
  }

  loginUsingMetamask(BuildContext context) async {
    connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        sessionStorage: sessionStorage,
        clientMeta: const PeerMeta(
            name: 'FiratMarvel',
            description: 'NFT Marketplace',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]));
    if (!connector!.connected) {
      try {
        var session = await connector?.createSession(onDisplayUri: (uri) async {
          _uri = uri;

          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });

        _session = session;
        print('Account: ${session?.accounts.first.toString()}');
        emit(state.copyWith(session: _session , uri: _uri));
        final navigator = Navigator.of(context);
        if (_session != null) {
          navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      } catch (exp) {
        print(exp);
      }
    }

  }

  Future logoutFromMetamask(BuildContext context) async {

    if (connector != null && connector!.connected) {
      await connector!.killSession();
      _session = null;
      connector = null;
      _uri =null;
    }
    emit(WalletState(_session, null, null));

      final navigator = Navigator.of(context);
      navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));

  }

}
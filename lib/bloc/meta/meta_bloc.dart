import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:flutter/foundation.dart';


part 'meta_state.dart';
part 'meta_event.dart';


class WalletConnectBloc extends Bloc<WalletConnectEvent, WalletConnectState> {
  WalletConnect? connector;

  WalletConnectBloc() : super(WalletConnectLoading()) {
    on<WalletConnectAppLoaded>((event, emit) async {
      if (connector != null) {
        emit(WalletConnectConnectionSuccess(connector!.session));
      } else {
        emit(WalletConnectInitial());
      }
    });

    on<WalletConnectConnectionRequested>((event, emit) async {
      emit(WalletConnectLoading());
      // * Currently, a new wallet connect instance must be initialized
      // Define a session storage
      final sessionStorage = WalletConnectSecureStorage();
      final session = await sessionStorage.getSession();
      // Create a connector
      connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        session: session,
        sessionStorage: sessionStorage,
        clientMeta: const PeerMeta(
          name: 'FiratMarvel',
          description: 'NFT Marketplace',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );

      // Subscribe to events
      connector!.registerListeners(
        onConnect: (status) => add(WalletConnectConnected(connector!.session)),
        onSessionUpdate: (response) => log('sessionUpdate: $response'),
        onDisconnect: () => add(WalletConnectDisconnected()),
      );

      // Create a new session
      if (!connector!.connected) {
        await connector!.createSession(
            chainId: 4160,
            onDisplayUri: (uri) {
              launchUrlString(uri, mode: LaunchMode.externalApplication);
            });

      } else {
        emit(WalletConnectConnectionSuccess(connector!.session));
      }
    });

    on<WalletConnectConnected>((event, emit) {
      emit(WalletConnectConnectionSuccess(event.session));
    });

    on<WalletConnectDisconnected>((event, emit) async {
      emit(WalletConnectLoading());
      // if serves because the event is raised 1 or 2 times depending on which side breaks the connection
      if (connector != null && connector!.connected) {
        await connector!.killSession();
        connector = null;
      }
      emit(WalletConnectInitial());
    });
  }
  @override
  void onChange(Change<WalletConnectState> change) {
    super.onChange(change);
    log('$change');
  }
}
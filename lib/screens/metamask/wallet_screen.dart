import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/bloc/meta/meta_bloc.dart';
import 'package:marvelapp/widgets/wallet_connect.dart';
import 'package:marvelapp/widgets/wallet_disconnect.dart';
import '../home_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletConnectBloc, WalletConnectState>(
        builder: (context, state) {
          if (state is WalletConnectConnectionSuccess) {
            final session = (context.watch<WalletConnectBloc>().state
            as WalletConnectConnectionSuccess)
                .session;
            return WalletConnectView(session: session, method:(){
              context.read<WalletConnectBloc>().add(WalletConnectDisconnected());
              final navigator = Navigator.of(context);
              navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
            });
          } else {
            return WalletDisconnectView(method: (){
              context.read<WalletConnectBloc>().add(WalletConnectConnectionRequested());
              final navigator = Navigator.of(context);
              navigator.pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
            });
          }
        });
  }
}
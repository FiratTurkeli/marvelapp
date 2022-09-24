import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/constants/background.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/constants/text_style.dart';
import 'package:marvelapp/widgets/app_bar.dart';
import '../bloc/character/char_bloc.dart';
import '../bloc/meta/meta_bloc.dart';
import '../widgets/character_card_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return background(
      Scaffold(
      backgroundColor: Colors.black54,
      appBar: MyAppBar(widget: BlocBuilder<WalletConnectBloc, WalletConnectState>(
        builder: (context, state){
         if (state is WalletConnectConnectionSuccess) {
           return const Icon(Icons.person, color: myWhite,);
         } else {
           return const Icon(Icons.wallet_sharp, color: myWhite,);
         }
        },
      )),
      body: Stack(children: [
        BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoadingState) {
              return const Center(child: LinearProgressIndicator(color: myWhite ,)
              );
            }
            if (state is CharacterLoadedState) {
              // character view with character card inside
              return CharacterView(state: state,);
            } else {
              return  Center(child: Text('Unexpected error. Please check your internet connection' , style: descriptionStyle,));
            }
          },
        ),
      ]),
    ),
    );
  }
}

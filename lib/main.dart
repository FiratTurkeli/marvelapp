import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/bloc/character/char_bloc.dart';
import 'package:marvelapp/bloc/meta/meta_bloc.dart';
import 'package:marvelapp/screens/splash_screen.dart';
import 'repo/char_repository.dart';
import 'bloc/bloc_observer.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Bloc providers
    return  MultiBlocProvider(
      providers: [
        // for metamask wallet
        BlocProvider( create: (context) => WalletConnectBloc()..add(WalletConnectAppLoaded())),
        //for marvel characters
        BlocProvider(create: (context) => CharacterBloc(CharacterRepositoryImpl())..add(FetchingCharacter())),
        //for metamask wallet (backup)
        //BlocProvider(create: (context) => WalletCubit()..initWalletConnect(), lazy: true,),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false ,
        home: SplashScreen(),
      ),
    );
  }
}



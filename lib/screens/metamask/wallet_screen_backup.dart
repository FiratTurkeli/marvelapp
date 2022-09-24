import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/metamask_backup/wallet_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/text_style.dart';



//Stateless Widget because i manage my states with bloc in this page
class MetamaskScreen extends StatelessWidget {
  const MetamaskScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    
    return
      BlocBuilder<WalletCubit,WalletState>(
        builder: (context,state){
          return  state.session != null
              ?   SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('${state.session?.accounts[0]}',style: descriptionStyle.copyWith(color: black)),
                  Text('${state.uri}',style: descriptionStyle.copyWith(color: black)),

                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(myDarkBlue)
                      ),
                      label: Text('Logout' , style: descriptionStyle.copyWith(color: myWhite),),
                      onPressed: () async {
                        context.read<WalletCubit>().logoutFromMetamask(context);
                      },
                      icon: const Icon(Icons.logout , color: myWhite,)
                  )
                ],
              ),
            ),
          )
              :


          SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () async {
                    context.read<WalletCubit>().loginUsingMetamask(context);
                  },
                      icon: Image.asset('images/metamask_backup.png')),
                  Text('Connect to MetaMask' , style: descriptionStyle.copyWith(color: black),)
                ],
              ),
            ),
          )
          ;
        },
      );


  }
}
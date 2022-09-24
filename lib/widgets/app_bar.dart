import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marvelapp/bloc/meta/meta_bloc.dart';
import 'package:marvelapp/screens/metamask/wallet_screen_backup.dart';
import 'package:marvelapp/screens/metamask/wallet_screen.dart';
import '../constants/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  Widget widget;
  MyAppBar({Key? key , required this.widget}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      shape:  const RoundedRectangleBorder(
        borderRadius:  BorderRadius.only(
            bottomLeft:  Radius.circular(20), bottomRight: Radius.circular(20)
        ),
      ),
      systemOverlayStyle:  const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: myDarkBlue,
      ),
      backgroundColor: myDarkBlue,
      elevation: 8,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed:(){
                showModalBottomSheet(

                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        )
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context){
                      return  WalletScreen(); // MetamaskScreen(); --> If you use cubit (backup)
                    }

                );

              },
              icon: widget
          ),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('images/marvel-studios.png' , width: 300, height: 40 , fit: BoxFit.contain,),
      ),
    );
  }



}


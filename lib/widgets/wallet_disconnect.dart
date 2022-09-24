import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import '../screens/home_screen.dart';

class WalletDisconnectView extends StatelessWidget {
  VoidCallback method;
  WalletDisconnectView({Key? key , required this.method}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 500,
        child: SingleChildScrollView(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: method,
                  icon: Image.asset('images/metamask.png')),
              Text('Connect to MetaMask',
                style: descriptionStyle.copyWith(color: black),)
            ],
          ),
        ),
      );
  }
}

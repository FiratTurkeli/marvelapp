
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_style.dart';

class WalletConnectView extends StatelessWidget {
  var session;
  VoidCallback method;
  WalletConnectView({Key? key , required this.session , required this.method}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${session.accounts[0]}',
                style: descriptionStyle.copyWith(color: black)),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        myDarkBlue)
                ),
                label: Text('Logout',
                  style: descriptionStyle.copyWith(
                      color: myWhite),),
                onPressed: method,
                icon: const Icon(Icons.logout, color: myWhite,)
            )
          ],
        ),
      ),
    );
  }
}

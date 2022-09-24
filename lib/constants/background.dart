import 'package:flutter/material.dart';

// background widget
Widget background(Widget widget){
   return Container(
     decoration: const BoxDecoration(
       image: DecorationImage(image: AssetImage('images/marvel_back.jpg'),
           fit: BoxFit.cover
       ),
     ),
     child: widget,
   );
}
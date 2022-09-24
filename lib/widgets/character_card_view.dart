import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvelapp/constants/colors.dart';
import 'package:marvelapp/constants/text_style.dart';
import 'package:marvelapp/screens/details_screen.dart';
import '../bloc/character/char_bloc.dart';
import '../model/comic_char.dart';

class CharacterView extends StatefulWidget {
  final CharacterLoadedState state;
  const CharacterView({Key? key, required this.state}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.8,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.85
            ),
        itemCount: widget.state.characters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return characterCard(widget.state.characters[index]);

        },


      )),
    );
  }


  Widget characterCard(MarvelCharacterModel character){
    double width = MediaQuery.of(context).size.width*0.7;
    double height = MediaQuery.of(context).size.height*0.5;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CharacterDetailsScreen(character: character)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
          child: Container(
            width: width,
            height: height*0.7,
            decoration: const BoxDecoration(
              color: myDarkBlue,
              borderRadius: BorderRadius.only( bottomRight: Radius.circular(40)),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                buildHeaderImage(character.thumbnailUrl.toString()),
                Positioned(
                  bottom: height*0.24,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/powercard.png', width: 27, height: 27,),
                  ),
                ),
                Positioned(
                  bottom: height*0.04,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          character.name.toUpperCase(),
                          style: nameStyle
                        ),
                        Text(
                          'Comics: ${character.comics.length.toString()}',
                          style: descriptionStyle
                        ),
                        Text(
                          'Series: ${character.series.length.toString()}',
                          style: descriptionStyle
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildHeaderImage(String photoUrl){
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height*0.5;
   return SizedBox(
     height: height/2,
     child: Stack(
        children: <Widget>[
          ClipPath(
              clipper: RoundedClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: myWhite,
                  border: Border.all(color: myWhite, width: 2),
                ),)),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipPath(
                clipper: RoundedClipper(),
                child: Image.network(
                  photoUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )),
          ),

        ],
      ),
   );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-70);
    path.quadraticBezierTo(
        size.width*0.5,
        size.height,
        size.width,
        size.height-35
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:marvelapp/model/comic_char.dart';
import '../constants/colors.dart';
import '../constants/text_style.dart';


class CharacterDetailsScreen extends StatefulWidget {

  final MarvelCharacterModel character;
  const CharacterDetailsScreen({Key? key , required this.character}) : super(key: key);
  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> with TickerProviderStateMixin {

  late Size size = MediaQuery.of(context).size;
  List? comics = [];
  late AnimationController controller;
  late AnimationController bodyScrollAnimationController;
  late ScrollController scrollController;
  late Animation<double> scale;
  late Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;
  String checkNum(int x){
    return x<10?"0$x":x.toString();
  }

  @override
  void initState() {
    comics = widget.character.comics;
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    bodyScrollAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.forward();
        } else {
          if (bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.reverse();
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          backgroundColor: myDarkBlue.withOpacity(0.8),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                  controller: scrollController,
                  child:buildCharacterDetailsView()
              ),

              AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCharacterDetailsView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildHeaderImage(widget.character.thumbnailUrl.toString(), widget.character.name.toString()),
        buildEventDetails(widget.character.name.toString(), widget.character.modified.toString(), widget.character.description.toString()),
        buildSeries(),
        Center(child: Image.asset('images/marvel.png' , width: MediaQuery.of(context).size.width/2, height: MediaQuery.of(context).size.height/10,)),

      ],
    );
  }

  Widget buildEventDetails(String characterName, String characterModified, String characterDescription){
    return  Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildModifiedDate(characterModified),
          buildCharacterTitle(characterName),
          buildAboutCharacter(characterDescription),

        ],
      ),
    );
  }


  Widget buildHeaderImage(String image, String name) {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta! / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: image,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildHeaderButtons(),
        ],
      ),
    );
  }

  Widget buildHeaderButtons() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              margin: const EdgeInsets.all(0),
              color: myWhite,
              child: InkWell(
                onTap: () {
                  if (bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.reverse();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color:  myRed,
                  ),
                ),
              ),
            ),
            Card(
              shape: const CircleBorder(),
              elevation: 0,
              color: myWhite,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: myRed),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterTitle(String name) {
    return Text(
      name,
      style: nameStyle.copyWith(fontSize: 32),
    );
  }

  Widget buildModifiedDate(var date) {
    final line = widget.character.modified.toString();
    DateTime x = DateTime.parse(line);
    return Container(
      decoration: BoxDecoration(
        color: myRed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Modified' , style: descriptionStyle.copyWith(fontSize: 12),)
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Text('${checkNum(x.year)}/${checkNum(x.month)}/${checkNum(x.day)}', style: descriptionStyle.copyWith(fontSize: 12)),
                Text('${checkNum(x.hour)}:${checkNum(x.minute)}', style: descriptionStyle.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutCharacter(String description) {
    return
      description == '' ?
      Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Description not found' , style: descriptionStyle.copyWith(fontSize: 12), textAlign: TextAlign.center,),
            ],
          ) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("DESCRIPTION", style: nameStyle.copyWith(fontSize: 18)),
          Text(description, style: descriptionStyle),

        ],
      );

  }

  Widget buildSeries() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('COMICS' , style: descriptionStyle.copyWith(decoration: TextDecoration.underline , color:  myWhite),),
          SizedBox(
            height: comics!.isEmpty ? 10 : size.height,
            child: ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: comics?.length,
              itemBuilder: (context, index) {
                return Text('${comics?[index]['name']}', style: descriptionStyle,);
              },
            ),
          ),
        ],
      ),
    );
  }



}
class MarvelCharacterModel {
  // character model class
  int id;
  String name;
  String? description;
  String? modified;
  String thumbnailUrl;
  String? resourceURI;
  List<dynamic> comics;
  List<dynamic> series;



  MarvelCharacterModel(
      {required this.id,
        required this.name,
        required this.description,
        required this.modified,
        required this.thumbnailUrl,
        required this.resourceURI,
        required this.series,
        required this.comics,
      });


  //creating the character model with the response from the browser
  static MarvelCharacterModel fromMapToModel(Map<String, dynamic> maps){
    return MarvelCharacterModel(
        id: maps['id'],
        name: maps['name'],
        description: maps['description'],
        modified:  maps['modified'],
        thumbnailUrl: '${maps['thumbnail']['path']}/portrait_xlarge.${maps['thumbnail']['extension']}',
        resourceURI: maps['resourceURI'],
        series: maps['series']['items'],
        comics: maps['comics']['items'],
    );

  }
}

class Comics {
  String? resourceURI;
  String? name;

  Comics({required this.resourceURI, required this.name});

  static Comics fromMapToMpdel(Map<String, dynamic> maps){
    return Comics(resourceURI: maps['resourceURI'],
        name: maps['name']
    );
  }

}


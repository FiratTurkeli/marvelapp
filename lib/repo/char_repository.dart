
import 'package:marvelapp/model/comic_char.dart';

import '../services/http_helper.dart';

class CharacterRepositoryImpl implements CharacterRepository {

  HttpHelper service = HttpHelper();
  @override
  // fetch all characters
  Future<List<MarvelCharacterModel>> fetchAllCharacters() {
    return service.get100Data(0);
  }

}

abstract class CharacterRepository {
  Future<List<MarvelCharacterModel>> fetchAllCharacters();
}

class NetworkError extends Error {

}
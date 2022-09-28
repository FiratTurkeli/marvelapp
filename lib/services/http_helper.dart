import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:marvelapp/model/comic_char.dart';


class HttpHelper {
  // marvel app keys
  final String baseUrl = 'gateway.marvel.com';
  final String apiKey =  '12e3fff2922326b5f3fc1426a67cf145';
  final String privateKey = '3b28c40f5d5c083f56bdadc5fc18daed64098ae7';
  Dio dio = Dio();
  String getHash(int timestamp) {
    return crypto.md5
        .convert(utf8.encode('$timestamp$privateKey$apiKey'))
        .toString();
  }




  //our method that will give us all the characters
  Future<List<MarvelCharacterModel>> getDatas(int offset) async {
    List<MarvelCharacterModel> listChar = [];
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    Uri url = Uri.https(baseUrl, '/v1/public/characters', {
      'apikey': apiKey,
      'hash': getHash(timestamp),
      'ts': '$timestamp',
      'limit': '100',
      //'offset' : offset
    });

    Response response = await dio.get(url.toString());

    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      var data = jsonResponse['data'] as Map<String, dynamic>;
      List<dynamic> results = data['results'];
      for (Map<String, dynamic> result in results) {
        MarvelCharacterModel character = MarvelCharacterModel.fromMapToModel(result);
        listChar.add(character);
      }
    } else {
      print(
          'Request failed with status: ${response.statusCode} ${response.data}');
    }
    return listChar;
  }

  // creating data list by number of elements !!!if you need!!!
  Future<List<MarvelCharacterModel>>  getData() async {
    List<MarvelCharacterModel> listChar = [];
    int totalElements = 0;
    int currentElements = 0; // statring element to send offset

    totalElements = await getTotalElements();
    while(currentElements < totalElements){
      listChar.addAll(await getDatas(currentElements));
      currentElements += 100;
    }
    return listChar;
  }


  //get all characters count !!!if you need!!!
  Future<int> getTotalElements() async {
    int totalElements = 0;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    Uri url = Uri.https(baseUrl, '/v1/public/characters', {
      'apikey': apiKey,
      'hash': getHash(timestamp),
      'ts': '$timestamp',
    });

    Response response = await dio.get(url.toString());
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      var data = jsonResponse['data'] as Map<String, dynamic>;
      totalElements = data['total'];
    } else {
      print(
          'Request failed with status: ${response.statusCode} ${response.data}');
    }
    return totalElements;
  }




  //request to get thumbnailurl listings if needed
  Future<void> getThumbnail(String thumbnailUrl) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    Uri url = Uri.https(baseUrl, '/v1/public/characters',
        {'apikey': apiKey,
          'hash': getHash(timestamp),
          'ts': '$timestamp'});

    Response response = await dio.get(url.toString(), );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.data) as Map<String, dynamic>;
      var data = jsonResponse['data'] as Map<String, dynamic>;
      List<dynamic> results = data['results'];
      for (Map<String, dynamic> result in results) {
        print(result['name']);
      }
    } else {
      print(
          'Request failed with status: ${response.statusCode} ${response.data}');
    }
  }
}

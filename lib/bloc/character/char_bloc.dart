import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../model/comic_char.dart';
import '../../repo/char_repository.dart';

part 'char_events.dart';
part 'char_state.dart';


//Bloc class to connect to character event and character state

class CharacterBloc extends Bloc<CharEvent, CharacterState> {
  final CharacterRepository _charRepository;

  //constructor of charbloc that calls character repository
  // initial for the super constructor and try the states in on<CharEvent> method
  CharacterBloc(this._charRepository) : super(CharInitial()) {
    on<CharEvent>((event, emit) async {
      try {
        emit(CharacterLoadingState());
        //fetch characters to to send loaded state
        List<MarvelCharacterModel> data = await _charRepository.fetchAllCharacters();
        emit(CharacterLoadedState(characters: data));
      } on Exception {
        emit(CharacterErrorState(message: "Couldn't fetch the list, please try again later!"));
      }
    });
  }
}
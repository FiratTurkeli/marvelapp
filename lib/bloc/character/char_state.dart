part of 'char_bloc.dart';


//abstract class to which other states will extend
@immutable
abstract class CharacterState extends Equatable {}


//character initial state
//props to compare the specified values.

class CharInitial extends CharacterState {
  @override
  List<Object> get props => [];
}


//character loading state
//props to compare the specified values.

class CharacterLoadingState extends CharacterState {
  @override
  List<Object> get props => [];
}


//character loaded state
//props to compare the specified('characters') values.

class CharacterLoadedState extends CharacterState {
  final List<MarvelCharacterModel> characters;
  CharacterLoadedState({required this.characters});

  @override
  List<Object> get props => [characters];
}


//character error state
//props to compare the specified('message') values.
class CharacterErrorState extends CharacterState {
  final String message;
  CharacterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

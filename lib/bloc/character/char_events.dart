part of 'char_bloc.dart';


//abstract class to which other states will extend
@immutable
abstract class CharEvent extends Equatable {
  const CharEvent();

}

// Fetching Characters event
//props to compare the specified values.
class FetchingCharacter extends CharEvent {
  @override
  List<Object> get props => [];
}
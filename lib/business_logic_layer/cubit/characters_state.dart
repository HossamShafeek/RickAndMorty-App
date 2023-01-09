
import 'package:rick_morty/data_layer/models/characters_model.dart';

abstract class CharactersState{}

class CharactersInitialState extends CharactersState{}

class CharactersLoadedState extends CharactersState{
  final List<CharacterModel> characters;

  CharactersLoadedState(this.characters);
}
class CharactersNotLoadedState extends CharactersState{
  final String error;

  CharactersNotLoadedState(this.error);
}

class CharactersLoadingState extends CharactersState{}
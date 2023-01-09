
import 'package:rick_morty/data_layer/models/characters_model.dart';
import 'package:rick_morty/data_layer/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final List<dynamic> characters =
        await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}

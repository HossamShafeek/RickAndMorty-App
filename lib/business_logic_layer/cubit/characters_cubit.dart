
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_morty/business_logic_layer/cubit/characters_state.dart';
import 'package:rick_morty/data_layer/models/characters_model.dart';
import 'package:rick_morty/data_layer/repository/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> characters=[];
  static CharactersCubit get({required BuildContext context})=>BlocProvider.of(context);

  CharactersCubit( this.charactersRepository) : super(CharactersInitialState());

  bool isInternetConnect=true;
  setValueInIsInternetConnect() async {
    isInternetConnect  = await InternetConnectionChecker().hasConnection;

  }

  List<CharacterModel> getAllCharacters(){
    setValueInIsInternetConnect();
    emit(CharactersLoadingState());
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters=characters;
    }).catchError((error){
      emit(CharactersNotLoadedState(error.toString()));
      print('=========================');
      print(error.toString());
      print('=========================');
    });
    return characters;
  }

}

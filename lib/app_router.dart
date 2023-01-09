
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/business_logic_layer/cubit/characters_cubit.dart';
import 'package:rick_morty/data_layer/models/characters_model.dart';
import 'package:rick_morty/data_layer/repository/characters_repository.dart';
import 'package:rick_morty/data_layer/web_services/characters_web_services.dart';
import 'package:rick_morty/presentation_layer/screens/character_details_screen.dart';
import 'package:rick_morty/presentation_layer/screens/characters_screen.dart';
import 'package:rick_morty/presentation_layer/screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String charactersScreen = '/characters_screen';
  static const String characterDetailsScreen = '/character_details';
}

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_)=> const SplashScreen());
      case Routes.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case Routes.characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) =>  CharacterDetailsScreen(character: character,));
    }
    return null;
  }
}

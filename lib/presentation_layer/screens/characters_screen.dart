import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rick_morty/business_logic_layer/cubit/characters_cubit.dart';
import 'package:rick_morty/business_logic_layer/cubit/characters_state.dart';
import 'package:rick_morty/constants/app_colors.dart';
import 'package:rick_morty/data_layer/models/characters_model.dart';
import 'package:rick_morty/data_layer/web_services/characters_web_services.dart';
import 'package:rick_morty/presentation_layer/widgets/character_item.dart';
import 'package:rick_morty/presentation_layer/widgets/circular_progress_indicator.dart';
import 'package:rick_morty/presentation_layer/widgets/no_internet.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  late List<CharacterModel> searchedForCharacters;
  bool _isSearching = false;
  TextEditingController _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.grey,
      maxLines: 1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Find a character ...',
        hintStyle: TextStyle(color: AppColors.grey, fontSize: 18),
      ),
      style: const TextStyle(color: AppColors.grey, fontSize: 18),
      onChanged: (searchedCharacter) {
        _addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void _addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters.where((character) {
      return character.name!.toLowerCase().startsWith(searchedCharacter);
    }).toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _clearSearch();
                Navigator.pop(context);
              });
            },
            icon: const Icon(
              Icons.clear,
              color: AppColors.grey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: AppColors.grey,
            )),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CharactersCubit.get(context: context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocConsumer<CharactersCubit, CharactersState>(
      listener: (context, state) {
        if (state is CharactersNotLoadedState) {
          MotionToast.warning(
            title:const Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            description:const Text("Check your Internet Connection",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            position: MotionToastPosition.top,
            padding: const EdgeInsets.only(top: 60),
            animationType: AnimationType.fromLeft,
          ).show(context);
        }
      },
      builder: (context, state) {
        if (CharactersCubit.get(context: context).isInternetConnect) {
          if (state is CharactersLoadingState) {
            return buildCircularIndicator();
          } else if (state is CharactersLoadedState) {
            allCharacters = (state).characters;
            return buildCharactersGridview();
          } else if (state is CharactersNotLoadedState) {
            return const NoInternet();
          }
          return const NoInternet();
        } else {
          return const NoInternet();
        }
      },
    );
  }

  Widget buildCharactersGridview() {
    return GridView.custom(
      padding: const EdgeInsets.all(15.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        pattern: const [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        ),
        childCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: AppColors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        elevation: 0,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        leading: _isSearching
            ? const BackButton(
                color: AppColors.grey,
              )
            : null,
        actions: _buildAppBarAction(),
      ),
      body: RefreshIndicator(
        color: AppColors.yellow,
        backgroundColor: AppColors.white,
        onRefresh: () {
          CharactersCubit.get(context: context).getAllCharacters();
          return Future(() => null);
        },
        child: buildBlocWidget(),
      ),
      // buildBlocWidget(),
    );
  }
}

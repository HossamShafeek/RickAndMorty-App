import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/app_router.dart';
import 'package:rick_morty/constants/app_colors.dart';
import 'package:rick_morty/data_layer/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  CharacterModel character;

  CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.characterDetailsScreen,
            arguments: character);
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            padding:
                const EdgeInsets.all(8),
            child: Center(
              child: Text(
                character.name!,
                style: const TextStyle(
                  color: AppColors.grey50,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: AppColors.grey100,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: character.image!,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.yellow,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.yellow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

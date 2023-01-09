import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/constants/app_colors.dart';
import 'package:rick_morty/data_layer/models/characters_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSlicerAppBar(context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(
        color: AppColors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: AppColors.yellow,
      elevation: 0,
      stretch: true,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            overflow: TextOverflow.ellipsis,
            character.name!,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
        background: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageUrl: character.image!,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.yellow,
              )),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.yellow,
              ),
            ),
            Container(
              height: 70,
              color: AppColors.black45,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: title,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        text: value,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 16,
        ),
      ),
    ]));
  }

  Widget buildDivider(context) {
    return Divider(
      color: AppColors.yellow,
      height: 50.0,
      thickness: 1.5,
      endIndent: MediaQuery.of(context).size.width * 0.1,
      indent: MediaQuery.of(context).size.width * 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          buildSlicerAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildCharacterInfo('Created : ', character.created!),
                      buildDivider(context),
                      buildCharacterInfo('Status : ', character.status!),
                      buildDivider(context),
                      buildCharacterInfo('Gender : ', character.gender!),
                      buildDivider(context),
                      buildCharacterInfo('Species : ', character.species!),
                      buildDivider(context),
                      buildCharacterInfo('Location : ', character.location!.name!),
                      buildDivider(context),
                      buildCharacterInfo('First seen in : ', character.location!.name!),
                      const SizedBox(height: 360,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/business_logic_layer/cubit/characters_cubit.dart';

import '../../constants/app_colors.dart';

class NoInternet extends StatelessWidget {

  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Lottie.asset(
            'assets/images/no_internet.json',
            width: 150,
            height: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0, top: 10.0),
          child: SizedBox(
            width: 200,
            height: 45,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),),),
                backgroundColor: MaterialStateProperty.all(AppColors.yellow),
              ),
              //elevation: 0,
              onPressed: () {
                CharactersCubit.get(context: context).getAllCharacters();
              },
              child: const Text(
                "Try Again",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,),
              ),
            ),
          ),
        )
      ],
    );
  }
}

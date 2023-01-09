import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty/app_router.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(RickAndMortyApp(appRouter: AppRouter()));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRouter;

  RickAndMortyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

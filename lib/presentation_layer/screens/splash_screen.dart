import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty/app_router.dart';
import 'package:rick_morty/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacementNamed(context, Routes.charactersScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Image.asset(
                'assets/images/splash.jpeg',
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 120.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  color: AppColors.yellow,
                  strokeWidth: 3.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

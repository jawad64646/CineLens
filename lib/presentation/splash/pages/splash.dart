import 'package:cinelens/core/configs/assets/app_images.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/presentation/auth/pages/sign_in.dart';
import 'package:cinelens/presentation/home/pages/home.dart';
import 'package:cinelens/presentation/splash/bloc/splash_cubit.dart';
import 'package:cinelens/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigation.pushReplacement(context, const Home());
        }

        if (state is Unauthenticated) {
          Navigation.pushReplacement(context, const SignIn());
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.splashBG),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

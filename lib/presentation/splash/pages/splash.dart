import 'package:cinelens/core/configs/assets/app_images.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/presentation/auth/pages/sign_in.dart';
import 'package:cinelens/presentation/home/pages/home.dart';
import 'package:cinelens/presentation/splash/bloc/splash_cubit.dart';
import 'package:cinelens/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  Future<bool> _hasInternet() async {
    return await InternetConnection().hasInternetAccess;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) async {
        final hasInternet = await _hasInternet();

        if (!hasInternet) {
          if (!context.mounted) return;

          _showNoInternetDialog(context);
          return;
        }

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

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
            'CineLens requires an internet connection '
            'to access movies and TV shows.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final connected = await InternetConnection().hasInternetAccess;

                if (connected && context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }
}

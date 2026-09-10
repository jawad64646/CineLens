import 'package:cinelens/core/configs/theme/app_theme.dart';

import 'package:cinelens/presentation/auth/bloc/auth_cubit.dart';
import 'package:cinelens/presentation/splash/bloc/splash_cubit.dart';
import 'package:cinelens/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:cinelens/presentation/splash/pages/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) async {
  setupDependencies();

  runApp(const CineLens());
}

class CineLens extends StatelessWidget {
  const CineLens({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit()..checkSignIn(),
        ),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),

        // Add more providers here:
        // BlocProvider<HomeCubit>(
        //   create: (context) => HomeCubit(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const Splash(),
      ),
    );
  }
}

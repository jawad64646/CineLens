import 'package:cinelens/common/widgets/basic_app_bar.dart';
import 'package:cinelens/core/configs/theme/app_colors.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/presentation/home/widgets/now_playing.dart';
import 'package:cinelens/presentation/home/widgets/popular_tvshows.dart';
import 'package:cinelens/presentation/home/widgets/trending_movies.dart';
import 'package:cinelens/presentation/search/pages/home_search.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        trailingIcon: IconButton(
          onPressed: () {
            Navigation.push(context, HomeSearch());
          },
          icon: Icon(Icons.search, size: 20),
        ),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "CINE",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: .w600,
                  fontSize: 30,
                ),
              ),
              TextSpan(
                text: "LENS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .w400,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _displayText(text: "Trending 🔥"),

              const SizedBox(height: 14),

              const TrendingMovies(),

              const SizedBox(height: 28),

              _displayText(text: "Now Playing"),

              const SizedBox(height: 14),

              const NowPlaying(),

              const SizedBox(height: 28),

              _displayText(text: "Popular Tv"),

              const SizedBox(height: 14),

              const Populartvshows(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayText({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }
}

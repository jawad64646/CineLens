import 'package:cinelens/common/helper/formatter_date.dart';
import 'package:cinelens/common/widgets/basic_app_bar.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/presentation/watch/widgets/movie_recommendation.dart';
import 'package:cinelens/presentation/watch/widgets/movie_similar.dart';
import 'package:cinelens/presentation/watch/widgets/video_player.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        back: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 30),
          onPressed: () {
            Navigation.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            children: [
              SizedBox(height: 5),
              VideoPlayer(videoID: movie.id.toString()),
              SizedBox(height: 10),
              displayTitle(movie.title ?? ""),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  displayDate(movie.releaseDate ?? DateTime.now()),
                  displayVoteAverage(movie.voteAverage ?? 0.0),
                ],
              ),
              SizedBox(height: 15),
              displayTitle("OverView"),
              SizedBox(height: 15),
              displayOverview(movie.overview ?? "OverView of the movie "),
              SizedBox(height: 10),
              displayTitle("Recommendation"),
              SizedBox(height: 10),
              RecommendationMovies(movieID: movie.id.toString()),
              displayTitle("Similar"),
              SizedBox(height: 10),
              SimilarMovies(movieID: movie.id.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayTitle(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: .w600, fontSize: 22),
    );
  }

  Widget displayDate(DateTime date) {
    return Row(
      children: [
        Icon(Icons.calendar_month),
        SizedBox(width: 5),
        Text(
          date.toReadableString(),
          style: TextStyle(color: Colors.grey, fontWeight: .w400, fontSize: 14),
        ),
      ],
    );
  }

  Widget displayVoteAverage(double vote) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow),
        SizedBox(width: 5),

        Text(
          vote.toStringAsFixed(1),
          style: TextStyle(color: Colors.grey, fontWeight: .w400, fontSize: 14),
        ),
      ],
    );
  }

  Widget displayOverview(String overView) {
    return Text(
      overView,
      style: TextStyle(color: Colors.white, fontWeight: .w400, fontSize: 16),
    );
  }
}

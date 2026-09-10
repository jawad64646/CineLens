import 'package:cinelens/common/helper/formatter_date.dart';
import 'package:cinelens/common/widgets/basic_app_bar.dart';
import 'package:cinelens/core/navigation/navigation.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/presentation/watch/widgets/tvshow_keywords.dart';
import 'package:cinelens/presentation/watch/widgets/tvshow_recommendation.dart';
import 'package:cinelens/presentation/watch/widgets/tvshow_similar.dart';
import 'package:cinelens/presentation/watch/widgets/video_player.dart';
import 'package:flutter/material.dart';

class TvShowDetail extends StatelessWidget {
  final TvShowEntity show;
  const TvShowDetail({super.key, required this.show});

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
              VideoPlayer(videoID: show.id.toString(), isTv: true),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  displayTitle(show.name ?? ""),
                  displayVoteAverage(show.voteAverage ?? 0.0),
                ],
              ),
              SizedBox(height: 15),
              KeywordsTvShow(tvshowId: show.id.toString()),
              SizedBox(height: 10),

              SizedBox(height: 15),
              displayTitle("OverView"),
              SizedBox(height: 15),
              displayOverview(show.overview ?? "OverView of the movie "),
              SizedBox(height: 10),
              displayTitle("Recommendation"),
              SizedBox(height: 10),
              Recommendationtvshow(showID: show.id.toString()),
              displayTitle("Similar"),
              SizedBox(height: 10),
              Similartvshow(showID: show.id.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayTitle(String text) {
    return Text(
      text,
      overflow: .clip,
      style: TextStyle(color: Colors.white, fontWeight: .w600, fontSize: 22),
    );
  }

  Widget displayDate(DateTime date) {
    return Row(
      children: [
        Icon(Icons.calendar_month),
        Text(
          date.toReadableString(),
          style: TextStyle(color: Colors.grey, fontWeight: .w400, fontSize: 14),
        ),
      ],
    );
  }

  Widget displayVoteAverage(double vote) {
    return Padding(
      padding: .only(right: 6),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Text(
            vote.toStringAsFixed(1),
            style: TextStyle(
              color: Colors.grey,
              fontWeight: .w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget displayOverview(String overView) {
    return Text(
      overView,
      style: TextStyle(color: Colors.white, fontWeight: .w400, fontSize: 16),
    );
  }
}

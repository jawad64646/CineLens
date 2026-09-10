import 'package:cinelens/core/configs/constant/app_urls.dart';
import 'package:cinelens/core/navigation/navigation.dart';

import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/presentation/watch/pages/tvshow_detail.dart';
import 'package:flutter/material.dart';

class TvShowCard extends StatelessWidget {
  final TvShowEntity show;

  const TvShowCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    final posterPath = show.posterPath ?? '';
    final title = show.originalName ?? '';
    final rating = show.voteAverage != null
        ? show.voteAverage?.toStringAsFixed(1)
        : '0.0';

    return GestureDetector(
      onTap: () {
        Navigation.push(context, TvShowDetail(show: show));
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppUrls.imageBaseUrl + posterPath),
                ),
              ),
            ),
            const SizedBox(height: 6),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),

            const SizedBox(width: 4),
            Text(
              "🌟 $rating",
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

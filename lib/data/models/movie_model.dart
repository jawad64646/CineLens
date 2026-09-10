import 'package:cinelens/domain/entities/movie_entity.dart';

class MovieModel {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? softcore;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      originalLanguage: json['original_language'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      releaseDate:
          json['release_date'] != null &&
              json['release_date'].toString().isNotEmpty
          ? DateTime.tryParse(json['release_date'].toString())
          : null,
      softcore: json['softcore'] as bool?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate?.toIso8601String(),
      'softcore': softcore,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

extension MovieModelToEntity on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType,
      originalLanguage: originalLanguage,
      genreIds: genreIds,
      popularity: popularity,
      releaseDate: releaseDate,
      softcore: softcore,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}

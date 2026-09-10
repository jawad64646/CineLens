import 'package:cinelens/domain/entities/tv_show_entity.dart';

class TvShowModel {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final DateTime? firstAirDate;
  final bool? softcore;
  final double? voteAverage;
  final int? voteCount;
  final List<String>? originCountry;

  TvShowModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.softcore,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      originalLanguage: json['original_language'] as String?,

      genreIds: json['genre_ids'] != null
          ? List<int>.from(
              (json['genre_ids'] as List).map((e) => (e as num).toInt()),
            )
          : null,

      popularity: (json['popularity'] as num?)?.toDouble(),

      firstAirDate: json['first_air_date'] != null
          ? DateTime.tryParse(json['first_air_date'].toString())
          : null,

      softcore: json['softcore'] as bool?,

      voteAverage: (json['vote_average'] as num?)?.toDouble(),

      voteCount: (json['vote_count'] as num?)?.toInt(),

      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'] as List)
          : null,
    );
  }
}

extension TvShowModelToEntity on TvShowModel {
  TvShowEntity toEntity() {
    return TvShowEntity(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType,
      originalLanguage: originalLanguage,
      genreIds: genreIds,
      popularity: popularity,
      firstAirDate: firstAirDate,
      softcore: softcore,
      voteAverage: voteAverage,
      voteCount: voteCount,
      originCountry: originCountry,
    );
  }
}

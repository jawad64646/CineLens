import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/common/widgets/trailer_model.dart';
import 'package:cinelens/core/configs/constant/app_urls.dart';
import 'package:cinelens/core/mixins/error_messange_mixin.dart';
import 'package:cinelens/core/network/dio_client.dart';
import 'package:cinelens/data/models/movie_model.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MovieApiService {
  Future<Either<String, List<MovieEntity>>> getTrendingMovies();
  Future<Either<String, List<MovieEntity>>> getNowPlaying();
  Future<Either<String, TrailerEntity>> getMovieTrailer(String? id);
  Future<Either<String, List<MovieEntity>>> getRecommendationBymovie(
    String? id,
  );
  Future<Either<String, List<MovieEntity>>> getSimilarBymovie(String? id);
  Future<Either<String, List<MovieEntity>>> getMoviesByquery(String query);
}

class MovieApiServiceImpl extends MovieApiService with GetErrorMessage {
  @override
  Future<Either<String, List<MovieEntity>>> getTrendingMovies() async {
    // TODO: implement getTrendingMovies
    try {
      final response = await getIt<DioClient>().get(AppUrls.getTrendingmovies);
      var entities = List.from(response.data['content']).map((e) {
        return MovieModel.fromJson(e).toEntity();
      }).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> getNowPlaying() async {
    // TODO: implement getNowPlaying
    try {
      final response = await getIt<DioClient>().get(AppUrls.nowPlayingmovies);
      var entities = List.from(response.data['content']).map((e) {
        return MovieModel.fromJson(e).toEntity();
      }).toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TrailerEntity>> getMovieTrailer(String? id) async {
    try {
      if (id == null || id.isEmpty) {
        return const Left("Movie ID is required");
      }

      final response = await getIt<DioClient>().get(
        "/api/v1/movie/$id/trailer",
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        return const Left("Invalid response format");
      }

      final trailer = data["trailer"];

      if (trailer == null) {
        return const Left("Trailer not found");
      }

      if (trailer is! Map<String, dynamic>) {
        return const Left("Invalid trailer data");
      }

      final entity = TrailerModel.fromJson(trailer).toEntity();

      return Right(entity);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> getRecommendationBymovie(
    String? id,
  ) async {
    try {
      final response = await getIt<DioClient>().get(
        "/api/v1/movie/$id/recommendations",
      );

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return MovieModel.fromJson(Map<String, dynamic>.from(e as Map))
            .toEntity();
      }).toList();

      return Right(entities);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> getSimilarBymovie(
    String? id,
  ) async {
    try {
      final response = await getIt<DioClient>().get(
        "/api/v1/movie/$id/similar",
      );

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return MovieModel.fromJson(Map<String, dynamic>.from(e as Map))
            .toEntity();
      }).toList();

      return Right(entities);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> getMoviesByquery(
    String query,
  ) async {
    // TODO: implement getMoviesByquery
    // router.get("/person/:query", searchPerson);
    // router.get("/movie/:query", searchMovie);
    // router.get("/tv/:query", searchTv);
    try {
      final response = await getIt<DioClient>().get(
        "/api/v1/search/movie/$query",
      );

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return MovieModel.fromJson(Map<String, dynamic>.from(e as Map))
            .toEntity();
      }).toList();

      return Right(entities);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
// {
//     "success": true,
//     "trailer": {
//         "iso_639_1": "en",
//         "iso_3166_1": "US",
//         "name": "Official Trailer - MY LIFE WITHOUT ME (2003, Sarah Polley, Scott Speedman)",
//         "key": "rxPRhy276ls",
//         "site": "YouTube",
//         "size": 1080,
//         "type": "Trailer",
//         "official": false,
//         "id": "63b12a2957530e008dcb2388",
//         "published_at": "2021-07-21T19:50:09.000Z"
//     }
// }

/*{
    "success": true,
    "content": [
        {
            "adult": false,
            "backdrop_path": "/5N456LS26jNCKYMcJWbEeDsvKWf.jpg",
            "id": 1137844,
            "title": "Mayday",
            "original_title": "Mayday",
            "overview": "When a U.S. Navy pilot on a top-secret mission during the Cold War gets trapped behind enemy lines, his only chance at survival is to form an alliance with an eccentric ex-KGB agent.",
            "poster_path": "/hVXjX1jLZ1ljFSNGXpjJfbTUOa7.jpg",
            "media_type": "movie",
            "original_language": "en",
            "genre_ids": [
                28,
                35,
                10752
            ],
            "popularity": 184.5833,
            "release_date": "2026-09-03",
            "softcore": false,
            "video": false,
            "vote_average": 7.846,
            "vote_count": 178
        },
        {
            "adult": false,
            "backdrop_path": "/qeQJx07rK2xm8SD2sJxFKhE7gs0.jpg",
            "id": 969681,
            "title": "Spider-Man: Brand New Day",
            "original_title": "Spider-Man: Brand New Day",
            "overview": "Fighting crime full-time as Spider-Man in a world that doesn't remember him—and the pressure of seeing his old friends move on without him—sparks a change in Peter Parker he may not have the power to control. But that transformation might also be the only thing that can stop a shocking new threat to the city and those he loves - a powerful villain no one can even see.",
            "poster_path": "/bjiS5ipwxb9JFy3XRRN4OAilSeX.jpg",
            "media_type": "movie",
            "original_language": "en",
            "genre_ids": [
                878,
                28,
                12
            ],
            "popularity": 851.9124,
            "release_date": "2026-07-29",
            "softcore": false,
            "video": false,
            "vote_average": 7.863,
            "vote_count": 2466
        },
        {
            "adult": false,
            "backdrop_path": "/ziXF8wIBguHNCeplNthUlDTCZP8.jpg",
            "id": 1386315,
            "title": "The Runner",
            "original_title": "The Runner",
            "overview": "Maia Marten, a brilliant London lawyer, has her life shattered by a single call on her morning run: her son has been taken. To get him back, she must keep running, obey every ruthless command, and trust no one-each second a test of how far a mother will go to save her child.",
            "poster_path": "/uxCaBoYXsDC4A0SqTm3SISj0OwK.jpg",
            "media_type": "movie",
            "original_language": "en",
            "genre_ids": [
                53,
                28
            ],
            "popularity": 295.2113,
            "release_date": "2026-09-03",
            "softcore": false,
            "video": false,
            "vote_average": 6.605,
            "vote_count": 253
        },
        {
            "adult": false,
            "backdrop_path": "/RMXG8myu1aGlNUsRjtxzmpdMK0.jpg",
            "id": 1368337,
            "title": "The Odyssey",
            "original_title": "The Odyssey",
            "overview": "Odysseus, the legendary King of Ithaca, embarks on a long and perilous journey home following the Trojan War. Throughout his voyage, he is forced to confront the whims of gods, mythological monsters, and trials that stretch both his cunning and his humanity to the breaking point.",
            "poster_path": "/5rhTDKUhPYvpdQIijFIs5VoWsON.jpg",
            "media_type": "movie",
            "original_language": "en",
            "genre_ids": [
                12,
                28,
                14
            ],
            "popularity": 482.5778,
            "release_date": "2026-07-15",
            "softcore": false,
            "video": false,
            "vote_average": 8,
            "vote_count": 3507
        },
        {
            "adult": false,
            "backdrop_path": "/rZfmzpixLKLR3Hg2u0WgC7XLFl8.jpg",
            "id": 1339713,
            "title": "Obsession",
            "original_title": "Obsession",
            "overview": "After breaking the mysterious \"One Wish Willow\" to win his crush's heart, a hopeless romantic finds himself getting exactly what he asked for but soon discovers that some desires come at a dark, sinister price.",
            "poster_path": "/bRwnj8WEKBCvmfeUNOukJPwB43K.jpg",
            "media_type": "movie",
            "original_language": "en",
            "genre_ids": [
                27,
                53
            ],
            "popularity": 218.4872,
            "release_date": "2026-05-13",
            "softcore": false,
            "video": false,
            "vote_average": 8.199,
            "vote_count": 5332
        }
    ]
}  */

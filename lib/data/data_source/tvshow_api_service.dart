import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/common/widgets/trailer_model.dart';
import 'package:cinelens/core/configs/constant/app_urls.dart';
import 'package:cinelens/core/mixins/error_messange_mixin.dart';
import 'package:cinelens/core/network/dio_client.dart';
import 'package:cinelens/data/models/keyword_tvshow.dart';
import 'package:cinelens/data/models/tv_show_model.dart';
import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TvshowApiService {
  Future<Either<String, List<TvShowEntity>>> getPopularTvShows();
  Future<Either<String, List<KeywordTvshowEntity>>> getKeywordsTVshow(
    String id,
  );
  Future<Either<String, List<TvShowEntity>>> getRecommendationBytv(String? id);
  Future<Either<String, List<TvShowEntity>>> getSimilarBytv(String? id);
  Future<Either<String, TrailerEntity>> getTvTrailer(String? id);
  Future<Either<String, List<TvShowEntity>>> getTvshowsByquery(String query);
}

class TvshowApiServiceImpl extends TvshowApiService with GetErrorMessage {
  @override
  Future<Either<String, List<TvShowEntity>>> getPopularTvShows() async {
    try {
      final response = await getIt<DioClient>().get(AppUrls.getPopulartvshows);

      final content = response.data['content'];

      if (content is List) {
        // If content is a List
        final entities = content
            .map((e) => TvShowModel.fromJson(e).toEntity())
            .toList();
        return Right(entities);
      } else if (content is Map<String, dynamic>) {
        // If content is a single object
        final entity = TvShowModel.fromJson(content).toEntity();
        return Right([entity]);
      }

      return const Right([]);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<KeywordTvshowEntity>>> getKeywordsTVshow(
    String? id,
  ) async {
    // TODO: implement getKeywordsTVshow
    try {
      final response = await getIt<DioClient>().get("/api/v1/tv/$id/keywords");

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return KeywordTvshowModel.fromJson(Map<String, dynamic>.from(e as Map))
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
  Future<Either<String, List<TvShowEntity>>> getRecommendationBytv(
    String? id,
  ) async {
    // TODO: implement getRecommendationBymovie
    try {
      final response = await getIt<DioClient>().get(
        "/api/v1/tv/$id/recommendations",
      );

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return TvShowModel.fromJson(Map<String, dynamic>.from(e as Map))
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
  Future<Either<String, List<TvShowEntity>>> getSimilarBytv(String? id) async {
    // TODO: implement getSimilarBymovie
    try {
      final response = await getIt<DioClient>().get("/api/v1/tv/$id/similar");

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return TvShowModel.fromJson(Map<String, dynamic>.from(e as Map))
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
  Future<Either<String, TrailerEntity>> getTvTrailer(String? id) async {
    try {
      final response = await getIt<DioClient>().get(
        AppUrls.tvTrailers(id ?? ''),
      );
      final trailersList = response.data["trailers"] as List<dynamic>;
      if (trailersList.isEmpty) {
        return const Left("No trailers found");
      }

      final trailerJson = trailersList.firstWhere(
        (element) => element['type'] == 'Trailer',
        orElse: () => trailersList.first,
      );

      final entity = TrailerModel.fromJson(
        Map<String, dynamic>.from(trailerJson as Map),
      ).toEntity();
      return Right(entity);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TvShowEntity>>> getTvshowsByquery(
    String query,
  ) async {
    // TODO: implement getTvshowsByquery
    try {
      final response = await getIt<DioClient>().get("/api/v1/search/tv/$query");

      final result = response.data["content"] as List<dynamic>;

      final entities = result.map((e) {
        return TvShowModel.fromJson(Map<String, dynamic>.from(e as Map))
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

/*{
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/mdbWfpbWhvxgG3k5MHpo90UgAUe.jpg",
            "id": 95350,
            "name": "Lanterns",
            "original_name": "Lanterns",
            "overview": "Two intergalactic cops, new recruit John Stewart and Lantern legend Hal Jordan, are drawn into a dark, Earth-based mystery as they investigate a murder in the American heartland.",
            "poster_path": "/gpC7h43xPMEV3goYMQShfJbTtLq.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                18,
                9648,
                10765
            ],
            "popularity": 218.9943,
            "first_air_date": "2026-08-16",
            "softcore": false,
            "vote_average": 8.3,
            "vote_count": 280,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/1erQOjm3PZP6PNVRIuxdNmesCBu.jpg",
            "id": 301626,
            "name": "A Tale of Two Cities",
            "original_name": "A Tale of Two Cities",
            "overview": "A pair of lookalikes, one a former French aristocrat and the other an alcoholic English lawyer, fall in love with the same woman amidst the turmoil of the French Revolution.",
            "poster_path": "/ht3OVVRBTrTeVtUVQiKSekjIFVH.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                18,
                9648
            ],
            "popularity": 23.3107,
            "first_air_date": "2026-09-06",
            "softcore": false,
            "vote_average": 9.571,
            "vote_count": 7,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/4XccmjsOmQZw8S2iW1wvlvmb5v1.jpg",
            "id": 125988,
            "name": "Silo",
            "original_name": "Silo",
            "overview": "In a ruined and toxic future, thousands live in a giant silo deep underground. After its sheriff breaks a cardinal rule and residents die mysteriously, engineer Juliette starts to uncover shocking secrets and the truth about the silo.",
            "poster_path": "/gMYZZvnkVNTqSVnVCphWbPXwWwb.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10765,
                18
            ],
            "popularity": 344.8377,
            "first_air_date": "2023-05-04",
            "softcore": false,
            "vote_average": 8.205,
            "vote_count": 2598,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/yG1wltFmkX5c5ocACKfpX0tp3SY.jpg",
            "id": 236235,
            "name": "The Gentlemen",
            "original_name": "The Gentlemen",
            "overview": "When aristocratic Eddie inherits the family estate, he discovers that it's home to an enormous weed empire — and its proprietors aren't going anywhere.",
            "poster_path": "/tw3tzfXaSpmUZIB8ZNqNEGzMBCy.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                35,
                18,
                80
            ],
            "popularity": 233.9356,
            "first_air_date": "2024-03-07",
            "softcore": false,
            "vote_average": 7.832,
            "vote_count": 880,
            "origin_country": [
                "GB"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/4NBYDOnEjAzyuP7CMkD5s7fs44K.jpg",
            "id": 113962,
            "name": "Lioness",
            "original_name": "Lioness",
            "overview": "Cruz Manuelos, a rough-around-the-edges but passionate young Marine, is recruited to join the CIA's Lioness Engagement Team to help bring down a terrorist organization from within. Joe, the station chief of the Lioness program, is tasked with training, managing and leading her female undercover operatives.",
            "poster_path": "/rzpHPSEgPTpRs8EHbygwsOw7jC0.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                18,
                10768
            ],
            "popularity": 378.4989,
            "first_air_date": "2023-07-23",
            "softcore": false,
            "vote_average": 8.136,
            "vote_count": 1475,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/2rmK7mnchw9Xr3XdiTFSxTTLXqv.jpg",
            "id": 37854,
            "name": "One Piece",
            "original_name": "ワンピース",
            "overview": "Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates.\n\nMonkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way.\n\nLuffy will do anything to get the One Piece and become King of the Pirates!",
            "poster_path": "/dB4EDhre2dsC2kxYDavyKWqLQwi.jpg",
            "media_type": "tv",
            "original_language": "ja",
            "genre_ids": [
                10759,
                35,
                16
            ],
            "popularity": 56.8177,
            "first_air_date": "1999-10-20",
            "softcore": false,
            "vote_average": 8.749,
            "vote_count": 5527,
            "origin_country": [
                "JP"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/40Dx3P1mllQq1jhgN3K8dlti6CS.jpg",
            "id": 329471,
            "name": "The Grand Tour",
            "original_name": "The Grand Tour",
            "overview": "Welcome to The Grand Tour. The world's greatest motoring show reboots with new presenters - Thomas Holland, James Engelsman and Francis Bourgeois - and its trademark blend of global adventure, incredible vehicles, epic stunts and strong opinions.",
            "poster_path": "/kq6XB6xmD86txW4UR32tT2JUiN9.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10764
            ],
            "popularity": 32.4585,
            "first_air_date": "2026-09-04",
            "softcore": false,
            "vote_average": 9.6,
            "vote_count": 5,
            "origin_country": [
                "GB"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/pF0qkRsrHkdYadPWY9AMeFZfcwk.jpg",
            "id": 108978,
            "name": "Reacher",
            "original_name": "Reacher",
            "overview": "Jack Reacher, a veteran military police investigator, has just recently entered civilian life. Reacher is a drifter, carrying no phone and the barest of essentials as he travels the country and explores the nation he once served.",
            "poster_path": "/f1VCQIG2iCyOookdgOzwtUpwWC0.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10759,
                80
            ],
            "popularity": 584.2322,
            "first_air_date": "2022-02-03",
            "softcore": false,
            "vote_average": 8.108,
            "vote_count": 3234,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/lYDwHYOR8PROQfSJGZ8LqvwUVcW.jpg",
            "id": 294486,
            "name": "The Long Watch",
            "original_name": "交锋",
            "overview": "A millennium-era leak case shaping cross-strait dynamics hides a covert tug-of-war between foreign forces and Chinese agents. In the late 90s, rookie Chunxiao and star agent Ma Qi foil plots together, but as time passes, the case reshapes all involved amid era-defining shifts.",
            "poster_path": "/gRe5FZjMWw8xXzWk1hxWuNQckOg.jpg",
            "media_type": "tv",
            "original_language": "zh",
            "genre_ids": [
                9648
            ],
            "popularity": 4.9823,
            "first_air_date": "2026-09-06",
            "softcore": false,
            "vote_average": 9.0,
            "vote_count": 1,
            "origin_country": [
                "CN"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/o0NsbcIvsllg6CJX0FBFY8wWbsn.jpg",
            "id": 30984,
            "name": "Bleach",
            "original_name": "BLEACH",
            "overview": "For as long as he can remember, Ichigo Kurosaki has been able to see ghosts. But when he meets Rukia, a Soul Reaper who battles evil spirits known as Hollows, he finds his life is changed forever. Now, with a newfound wealth of spiritual energy, Ichigo discovers his true calling: to protect the living and the dead from evil.",
            "poster_path": "/2EewmxXe72ogD0EaWM8gqa0ccIw.jpg",
            "media_type": "tv",
            "original_language": "ja",
            "genre_ids": [
                10759,
                16,
                10765
            ],
            "popularity": 144.8544,
            "first_air_date": "2004-10-05",
            "softcore": false,
            "vote_average": 8.355,
            "vote_count": 2262,
            "origin_country": [
                "JP"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/4xKG4S1IyLIglHbCYGJDsptgQNh.jpg",
            "id": 615,
            "name": "Futurama",
            "original_name": "Futurama",
            "overview": "The adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century.",
            "poster_path": "/eM8bbTn8C8vUwwS6upzzm7gX31u.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                16,
                35,
                10765
            ],
            "popularity": 100.1787,
            "first_air_date": "1999-03-28",
            "softcore": false,
            "vote_average": 8.365,
            "vote_count": 3883,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/j9fRIimor0AMFJR9kjZubXcABzZ.jpg",
            "id": 94664,
            "name": "Mushoku Tensei: Jobless Reincarnation",
            "original_name": "無職転生 ～異世界行ったら本気だす～",
            "overview": "When a 34-year-old underachiever gets run over by a truck, his story doesn't end there. Reincarnated in a new world as an infant, Rudy will seize every opportunity to live the life he's always wanted. Armed with new friends, some freshly acquired magical abilities, and the courage to do the things he's always dreamed of, he's embarking on an epic adventure—with all of his past experience intact!",
            "poster_path": "/gLKOYIMyKlUHW0SVdskhgf9C0yy.jpg",
            "media_type": "tv",
            "original_language": "ja",
            "genre_ids": [
                10759,
                16,
                10765
            ],
            "popularity": 149.9855,
            "first_air_date": "2021-01-11",
            "softcore": false,
            "vote_average": 8.4,
            "vote_count": 1704,
            "origin_country": [
                "JP"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/iBc82qaA05ntzSnrVndw8scv4Bn.jpg",
            "id": 196322,
            "name": "Dark Matter",
            "original_name": "Dark Matter",
            "overview": "Jason Dessen is abducted into an alternate version of his life. To get back to his real family, he embarks on a harrowing journey to save them from the most terrifying foe imaginable: himself.",
            "poster_path": "/2DPmTlv8F0V1TQBPmlsGOVOhtWk.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10765,
                18
            ],
            "popularity": 82.2335,
            "first_air_date": "2024-05-07",
            "softcore": false,
            "vote_average": 7.798,
            "vote_count": 762,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/oUFUvEMCBP80e4eYsfVfxC8n7ih.jpg",
            "id": 299952,
            "name": "The Early Spring",
            "original_name": "早春晴朗",
            "overview": "New to Beijing, Shang Zhitao crosses paths with Luan Nian, a true creative genius. Bold and open-hearted, she grows stronger step by step and gradually breaks through the defenses around Luan's guarded heart. Drawn to each other, they find themselves caught in an intense, on-again, off-again relationship in the urban jungle. To love is to summon all your courage and leave no regrets, to heal each other, and to grow together. But when love and her career pull her in different directions, she puts her career first. When she has come into her own and he has learned to soften his sharp edges, they finally stand as equals, ready to write a new ending together...",
            "poster_path": "/yiAzR6wGqjyAotZ4DvFvFeo8QS0.jpg",
            "media_type": "tv",
            "original_language": "zh",
            "genre_ids": [
                18
            ],
            "popularity": 148.5582,
            "first_air_date": "2026-08-26",
            "softcore": false,
            "vote_average": 7.688,
            "vote_count": 8,
            "origin_country": [
                "CN"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/iAOPgUlh7inOebFrUFHAjnFRCGS.jpg",
            "id": 287238,
            "name": "Furious",
            "original_name": "Furious",
            "overview": "FBI agent Alice Black is on the hunt for a mysterious and calculating female serial killer. Both walk their own paths toward justice, and as their lives start to intertwine, the line between right and wrong begins to blur.",
            "poster_path": "/xnxxrEKtBaIcI1ewq50pLkOMU6u.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                18,
                80
            ],
            "popularity": 76.9695,
            "first_air_date": "2026-07-27",
            "softcore": false,
            "vote_average": 7.2,
            "vote_count": 103,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/vV5LKWmuysEe5wsuZJGbdiL5XJ2.jpg",
            "id": 194583,
            "name": "The Walking Dead: Dead City",
            "original_name": "The Walking Dead: Dead City",
            "overview": "Maggie and Negan travel to post-apocalyptic Manhattan - long ago cut off from the mainland. The crumbling city is filled with the dead and denizens who have made it a world full of anarchy, danger, beauty, and terror.",
            "poster_path": "/wq3vuQzQgbS83zX3malAFWMsSwX.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10759,
                18,
                10765
            ],
            "popularity": 60.2613,
            "first_air_date": "2023-06-18",
            "softcore": false,
            "vote_average": 7.898,
            "vote_count": 791,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/wGmJg0wHBpifiHFsC6VgAOlQTge.jpg",
            "id": 247168,
            "name": "Chad Powers",
            "original_name": "Chad Powers",
            "overview": "Eight years after an unforgivable mistake nukes his promising college football career, hotshot quarterback Russ Holliday tries to resurrect his dreams by disguising himself as Chad Powers - a talented oddball who walks on to the struggling South Georgia Catfish.",
            "poster_path": "/aXetUcD4wfalCj90QmT6kSvwO6D.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                35
            ],
            "popularity": 57.3647,
            "first_air_date": "2025-09-30",
            "softcore": false,
            "vote_average": 7.935,
            "vote_count": 116,
            "origin_country": [
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/woa9xtYfw1dib4JLnvQdLSZK0D2.jpg",
            "id": 283319,
            "name": "Marble Hall Murders",
            "original_name": "Marble Hall Murders",
            "overview": "Returning to England, Susan Ryeland is reluctantly drawn into a new Atticus Pünd mystery, this time written by a new, young writer. 'Pünd’s Last Case\" is a story set in 1955, in an exotic villa in Corfu – but the identity of a real killer is hidden in the text, and once again Susan is going to find herself in grave danger.",
            "poster_path": "/3WfgRJBIaOTsiu2bQO23xWb08ro.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                9648,
                80
            ],
            "popularity": 6.0463,
            "first_air_date": "2026-09-06",
            "softcore": false,
            "vote_average": 7.0,
            "vote_count": 1,
            "origin_country": [
                "GB"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/tQqbbxBAdW2ql8vbOqMOJbtSQ7O.jpg",
            "id": 247718,
            "name": "MobLand",
            "original_name": "MobLand",
            "overview": "Two mob families clash in a war that threatens to topple empires and lives.",
            "poster_path": "/abeH7n5pcuQcwYcTxG6DTZvXLP1.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                80,
                18
            ],
            "popularity": 60.9931,
            "first_air_date": "2025-03-30",
            "softcore": false,
            "vote_average": 8.353,
            "vote_count": 822,
            "origin_country": [
                "GB",
                "US"
            ]
        },
        {
            "adult": false,
            "backdrop_path": "/577eXC8wFQT0eUrJcgznSiFPRmk.jpg",
            "id": 94997,
            "name": "House of the Dragon",
            "original_name": "House of the Dragon",
            "overview": "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "poster_path": "/7V0Ebks0GgpKvQ7QbLAIdX5dos4.jpg",
            "media_type": "tv",
            "original_language": "en",
            "genre_ids": [
                10765,
                18,
                10759
            ],
            "popularity": 118.0611,
            "first_air_date": "2022-08-21",
            "softcore": false,
            "vote_average": 8.383,
            "vote_count": 7092,
            "origin_country": [
                "US"
            ]
        }
    ],
    "total_pages": 500,
    "total_results": 10000
} */

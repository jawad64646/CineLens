class AppUrls {
  static const baseUrl = "https://movie-app-production-25c6.up.railway.app";
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static const String _version = "/api/v1/";

  static const signup = "${_version}auth/signup";
  static const signin = "${_version}auth/signin";

  // //////////////////////////////////////////////////////////////
  // static const logout = "/api/v1/auth/logout";/////////////////
  // static const authCheck = "/api/v1/auth/authCheck";///////////
  // ///////////////////////////////////////////////////////////////

  //movie:
  static const getTrendingmovies = "${_version}movie/trending";
  static const nowPlayingmovies = "${_version}movie/nowplaying";

  //tv:
  static const getPopulartvshows = "${_version}tv/popular";
  static const getTrendingtvshows = "${_version}tv/trending";
  static String tvTrailers(String id) => "${_version}tv/$id/trailers";
}

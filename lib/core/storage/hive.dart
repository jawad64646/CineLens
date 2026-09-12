import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveHelper {
  static const String moviesBox = "movies";
  static const String tvShowsBox = "tv_shows";
  static const String searchBox = "search";

  static void init() async {
    await Hive.initFlutter();

    await Hive.openBox(moviesBox);
    await Hive.openBox(tvShowsBox);
    await Hive.openBox(searchBox);
  }

  ////////////////////Movie///////////////////////////

  static dynamic getMovie(String key) {
    return Hive.box(moviesBox).get(key);
  }

  static Future<void> putMovie(String key, dynamic value) async {
    await Hive.box(moviesBox).put(key, value);
  }

  static void deleteMovie(String key) async {
    await Hive.box(moviesBox).delete(key);
  }

  ////////////////////TvShow///////////////////////////

  static dynamic gettvshow(String key) {
    return Hive.box(tvShowsBox).get(key);
  }

  static void puttvshow(String key, dynamic value) async {
    await Hive.box(tvShowsBox).put(key, value);
  }

  static void deletetvshow(String key) async {
    await Hive.box(tvShowsBox).delete(key);
  }

  ////////////////////Search///////////////////////////

  static dynamic getSearch(String key) {
    return Hive.box(searchBox).get(key);
  }

  static void putSearch(String key, dynamic value) async {
    await Hive.box(searchBox).put(key, value);
  }

  static void deleteSearch(String key) async {
    await Hive.box(searchBox).delete(key);
  }

  ///////////////////General/////////////////////

  static void clearAll() async {
    await Hive.box(moviesBox).clear();
    await Hive.box(tvShowsBox).clear();
    await Hive.box(searchBox).clear();
  }

  static void close() async {
    await Hive.close();
  }
}

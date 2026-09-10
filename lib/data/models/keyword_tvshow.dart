import 'package:cinelens/domain/entities/keyword_tvshow.dart';

class KeywordTvshowModel {
  KeywordTvshowModel({required this.name, required this.id});

  final String? name;
  final int? id;

  factory KeywordTvshowModel.fromJson(Map<String, dynamic> json) {
    return KeywordTvshowModel(name: json["name"], id: json["id"]);
  }

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}

extension keywordModel2Entity on KeywordTvshowModel {
  KeywordTvshowEntity toEntity() {
    return KeywordTvshowEntity(id: id, name: name);
  }
}

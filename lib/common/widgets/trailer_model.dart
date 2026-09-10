import 'package:cinelens/common/widgets/trailer_entity.dart';

class TrailerModel {
  TrailerModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
    required this.publishedAt,
  });

  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? id;
  final DateTime? publishedAt;

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      iso6391: json["iso_639_1"],
      iso31661: json["iso_3166_1"],
      name: json["name"],
      key: json["key"],
      site: json["site"],
      size: json["size"],
      type: json["type"],
      official: json["official"],
      id: json["id"],
      publishedAt: DateTime.tryParse(json["published_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391,
    "iso_3166_1": iso31661,
    "name": name,
    "key": key,
    "site": site,
    "size": size,
    "type": type,
    "official": official,
    "id": id,
    "published_at": publishedAt?.toIso8601String(),
  };
}

extension TrailerModelToEntity on TrailerModel {
  TrailerEntity toEntity() {
    return TrailerEntity(
      iso6391: iso6391,
      iso31661: iso31661,
      name: name,
      key: key,
      site: site,
      size: size,
      type: type,
      official: official,
      id: id,
      publishedAt: publishedAt,
    );
  }
}

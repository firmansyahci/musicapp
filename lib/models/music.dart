import 'dart:convert';

Music musicFromJson(String str) => Music.fromJson(json.decode(str));

String musicToJson(Music data) => json.encode(data.toJson());

class Music {
  Music({
    this.resultCount,
    this.results,
  });

  int? resultCount;
  List<Result>? results;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        resultCount: json["resultCount"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.artistName,
    this.trackName,
    this.previewUrl,
    this.artworkUrl100,
  });

  String? artistName;
  String? trackName;

  String? previewUrl;

  String? artworkUrl100;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        artistName: json["artistName"],
        trackName: json["trackName"],
        previewUrl: json["previewUrl"],
        artworkUrl100: json["artworkUrl100"],
      );

  Map<String, dynamic> toJson() => {
        "artistName": artistName,
        "trackName": trackName,
        "previewUrl": previewUrl,
        "artworkUrl100": artworkUrl100,
      };
}

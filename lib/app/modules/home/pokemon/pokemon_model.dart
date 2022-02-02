// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromJson(jsonString);

List<Result> pokemonFromJson(List str) =>
    List<Result>.from(str.map((x) => Result.fromJson(x)));

class Result {
  Result({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

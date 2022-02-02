List<TypeElement> pokemonDetailsFromJson(List str) =>
    List<TypeElement>.from(str.map((x) => TypeElement.fromJson(x)));

class TypeElement {
  TypeElement({
    this.slot,
    this.type,
  });

  int? slot;
  TypeType? type;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
    slot: json["slot"],
    type: TypeType.fromJson(json["type"]),
  );
}

class TypeType {
  TypeType({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
    name: json["name"],
    url: json["url"],
  );
}


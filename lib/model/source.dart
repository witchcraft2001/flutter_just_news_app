class Source {
  String id;
  String name;

  Source(this.id, this.name);

  Source.fromMappedJson(Map<String, dynamic> json) :
        id = json['id'] ?? "",
        name = json['name'] ?? "";
}
class Country {
  String id;
  String name;

  Country(this.id, this.name);

  Country.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class CountryList {
  List<Country> countriesList;

  CountryList(this.countriesList);

  CountryList.fromMappedJson(Map<String, dynamic> json) {
    var list = json['countries'] as List;
    countriesList = list.map((i) => Country.fromMappedJson(i)).toList();
  }
}
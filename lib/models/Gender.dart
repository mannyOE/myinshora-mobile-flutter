class Gender {
  String id;
  String name;

  Gender({
    this.id,
    this.name,
  });

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Quote {
  int premium;
  String currency;

  Quote({
    this.premium,
    this.currency,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      currency: json['currency'],
      premium: json['premium'],
    );
  }
}

class Titles {
  String id;
  String name;

  Titles({
    this.id,
    this.name,
  });

  factory Titles.fromJson(Map<String, dynamic> json) {
    return Titles(
      name: json['name'],
      id: json['id'],
    );
  }
}

class Category {
  String id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      id: json['id'],
    );
  }
}

class HairDresseModel{
 final String name;
 final int price;
 String style;
 final String description;
 String image;

  HairDresseModel({this.name, this.price, this.style, this.description, this.image});

  factory HairDresseModel.fromJson (Map<String, dynamic> json) => HairDresseModel(
    name: json["name"],
    price: 13,
    style: json["style"],
    description: json["description"],
    image: json["image"]
  );

   Map<String, dynamic> toJson() => {"name": name, "price": price, "style": style, "description": description, "image": image};

}
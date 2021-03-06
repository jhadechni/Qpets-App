class Product {
  String id;
  String image;
  String name;
  String storeName;
  String price;
  String type;
  String description;
  String facebook;
  String instagram;
  String phoneNumber;
  String ownerId;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.storeName,
    required this.price,
    required this.type,
    required this.description,
    required this.facebook,
    required this.instagram,
    required this.phoneNumber,
    required this.ownerId
  });

  // Getters
  String get getName => name;

  String get getstoreName => storeName;

  String get getPrice => price;

  String get getType => type;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "image": image,
      'name': name,
      'storeName': storeName,
      'price': price,
      'type': type,
      'description': description,
      'facebook': facebook,
      'instagram': instagram,
      'phoneNumber': phoneNumber,
      'ownerId' : ownerId
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['_id'],
        image: (json['image'] == "")
            ? "https://cdn.discordapp.com/attachments/803757598599151706/978519440343846932/not_found.png"
            : json["image"],
        name: json['name'],
        storeName: json['storeName'],
        price: json['price'],
        type: json['type'],
        description: json['description'],
        facebook: json['facebook'],
        instagram: json['instagram'],
        phoneNumber: json['phoneNumber'],
        ownerId : json['ownerId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['storeName'] = storeName;
    data['price'] = price;
    data['type'] = type;
    data['description'] = description;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['phoneNumber'] = phoneNumber;
    data['ownerId'] = ownerId;
    return data;
  }
}
